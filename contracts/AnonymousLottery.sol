// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Simplified FHE implementation for anonymous lottery
contract AnonymousLottery {

    struct LotteryEntry {
        address participant;
        bytes32 encryptedNumbers; // Encrypted combination of 3 numbers
        uint256 ticketCount;
        uint256 timestamp;
    }

    struct Winner {
        address winner;
        uint256 prize;
        uint8 num1;
        uint8 num2;
        uint8 num3;
        uint256 timestamp;
    }

    address public owner;
    uint256 public entryFee = 0.00001 ether;
    uint256 public prizePool;
    bool public isActive = true;
    uint256 public roundNumber = 1;

    LotteryEntry[] public entries;
    Winner[] public winners;

    // Mapping to track participant entries and wins
    mapping(address => uint256) public participantEntries;
    mapping(address => bool) public hasWon;
    mapping(uint256 => bytes32) private roundSecrets;

    event LotteryEntered(
        address indexed participant,
        uint256 ticketCount,
        uint256 totalEntries,
        uint256 round
    );

    event WinnerDrawn(
        address indexed winner,
        uint256 prize,
        uint8 num1,
        uint8 num2,
        uint8 num3,
        uint256 round
    );

    event LotteryReset(uint256 newRound);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyActive() {
        require(isActive, "Lottery is not active");
        _;
    }

    constructor() {
        owner = msg.sender;
        // Initialize random seed for this round
        roundSecrets[roundNumber] = keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender));
    }

    // FHE-like encryption using keccak256 hash
    function encryptNumbers(bool _num1, bool _num2, bool _num3, address _participant)
        internal
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(_num1, _num2, _num3, _participant));
    }

    // Simulate FHE decryption for winner revelation
    function decryptNumbers(bytes32 _encrypted, address _participant)
        internal
        pure
        returns (uint8, uint8, uint8)
    {
        bytes32 hash = keccak256(abi.encodePacked(_encrypted, _participant));
        uint8 num1 = uint8(hash[0]) % 50 + 1;
        uint8 num2 = uint8(hash[1]) % 50 + 1;
        uint8 num3 = uint8(hash[2]) % 50 + 1;
        return (num1, num2, num3);
    }

    function enterLottery(
        bool _num1,
        bool _num2,
        bool _num3
    ) external payable onlyActive {
        require(msg.value >= entryFee, "Insufficient entry fee");

        uint256 ticketCount = msg.value / entryFee;
        require(ticketCount > 0 && ticketCount <= 10, "Invalid ticket count");

        // Encrypt the numbers using our FHE-like function
        bytes32 encryptedNumbers = encryptNumbers(_num1, _num2, _num3, msg.sender);

        // Add entries for each ticket
        for (uint256 i = 0; i < ticketCount; i++) {
            entries.push(LotteryEntry({
                participant: msg.sender,
                encryptedNumbers: encryptedNumbers,
                ticketCount: ticketCount,
                timestamp: block.timestamp
            }));
        }

        participantEntries[msg.sender] += ticketCount;
        prizePool += msg.value;

        emit LotteryEntered(msg.sender, ticketCount, entries.length, roundNumber);
    }

    function drawWinner() external onlyOwner onlyActive returns (address) {
        require(entries.length > 0, "No entries in lottery");

        // Generate random index using multiple sources of randomness
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(
            block.timestamp,
            block.difficulty,
            entries.length,
            roundSecrets[roundNumber],
            msg.sender
        ))) % entries.length;

        LotteryEntry storage winningEntry = entries[randomIndex];
        address winner = winningEntry.participant;

        // Decrypt the winning numbers
        (uint8 num1, uint8 num2, uint8 num3) = decryptNumbers(
            winningEntry.encryptedNumbers,
            winner
        );

        // Calculate prize distribution
        uint256 prize = (prizePool * 80) / 100; // 80% to winner
        uint256 ownerFee = prizePool - prize;    // 20% to owner

        // Mark winner
        hasWon[winner] = true;

        // Record winner
        winners.push(Winner({
            winner: winner,
            prize: prize,
            num1: num1,
            num2: num2,
            num3: num3,
            timestamp: block.timestamp
        }));

        // Transfer prizes
        payable(winner).transfer(prize);
        payable(owner).transfer(ownerFee);

        emit WinnerDrawn(winner, prize, num1, num2, num3, roundNumber);

        // Reset for next round
        resetLottery();

        return winner;
    }

    function resetLottery() internal {
        delete entries;
        prizePool = 0;
        roundNumber++;

        // Generate new secret for next round
        roundSecrets[roundNumber] = keccak256(abi.encodePacked(
            block.timestamp,
            block.difficulty,
            roundNumber,
            address(this)
        ));

        emit LotteryReset(roundNumber);
    }

    // View functions
    function getParticipants() external view returns (address[] memory) {
        address[] memory participants = new address[](entries.length);
        for (uint256 i = 0; i < entries.length; i++) {
            participants[i] = entries[i].participant;
        }
        return participants;
    }

    function getPrizePool() external view returns (uint256) {
        return prizePool;
    }

    function getEntryFee() external view returns (uint256) {
        return entryFee;
    }

    function getEntryCount() external view returns (uint256) {
        return entries.length;
    }

    function getCurrentRound() external view returns (uint256) {
        return roundNumber;
    }

    function getWinningNumbers() external view returns (uint8, uint8, uint8) {
        require(winners.length > 0, "No winners yet");
        Winner memory lastWinner = winners[winners.length - 1];
        return (lastWinner.num1, lastWinner.num2, lastWinner.num3);
    }

    function getLastWinner() external view returns (address) {
        require(winners.length > 0, "No winners yet");
        return winners[winners.length - 1].winner;
    }

    function getAllWinners() external view returns (Winner[] memory) {
        return winners;
    }

    function isLotteryActive() external view returns (bool) {
        return isActive;
    }

    function getParticipantHistory(address _participant) external view returns (uint256) {
        return participantEntries[_participant];
    }

    function hasParticipantWon(address _participant) external view returns (bool) {
        return hasWon[_participant];
    }

    // Owner functions
    function setLotteryActive(bool _active) external onlyOwner {
        isActive = _active;
    }

    function setEntryFee(uint256 _newFee) external onlyOwner {
        entryFee = _newFee;
    }

    function emergencyWithdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // Allow direct donations to prize pool
    receive() external payable {
        prizePool += msg.value;
    }

    fallback() external payable {
        prizePool += msg.value;
    }
}