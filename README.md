# Anonymous Lottery System - Privacy Lottery Platform

An innovative blockchain-based lottery system that leverages Fully Homomorphic Encryption (FHE) technology to ensure complete privacy and anonymity for participants while maintaining transparency and fairness.

## 🔒 Core Concepts

### FHE Contract Anonymous Lottery System - Privacy Lottery Platform

This project implements a revolutionary approach to online lotteries by combining blockchain transparency with cryptographic privacy. The system uses Fully Homomorphic Encryption (FHE) to protect participant data while enabling verifiable random selection of winners.

**Key Privacy Features:**
- **Encrypted Number Selection**: Participant lottery numbers are encrypted before being stored on-chain
- **Anonymous Participation**: No personal information is required or stored
- **Verifiable Randomness**: Cryptographically secure winner selection process
- **Privacy-Preserving Verification**: Winners can be verified without revealing other participants' data

## 🎯 How It Works

1. **Number Selection**: Players choose three numbers (1-50) for their lottery entry
2. **Encryption Process**: Numbers are encrypted using FHE technology before blockchain submission
3. **Anonymous Storage**: Only encrypted data is stored on the blockchain
4. **Random Drawing**: Smart contract uses cryptographic randomness to select winners
5. **Privacy-Preserving Reveal**: Winner's numbers are revealed while maintaining others' privacy

## 🌟 Features

- **🔐 Full Privacy Protection**: Complete anonymity for all participants
- **⛓️ Blockchain Transparency**: All transactions are publicly verifiable
- **🎲 Provably Fair**: Cryptographically secure random number generation
- **💰 Automatic Payouts**: Smart contract handles prize distribution automatically
- **📱 Web3 Integration**: Seamless MetaMask wallet connectivity
- **⚡ Real-time Updates**: Live lottery statistics and winner announcements
- **🔄 Multiple Rounds**: Continuous lottery rounds with automatic reset

## 🔧 Technical Architecture

- **Smart Contract**: Solidity-based FHE implementation with encrypted storage
- **Frontend**: Modern web interface with Web3 integration
- **Encryption**: Keccak256-based FHE simulation for privacy protection
- **Blockchain**: Deployed on Ethereum Sepolia testnet
- **Wallet Integration**: MetaMask support for seamless transactions

## 📊 Contract Information

**Contract Address**: `0x5Ad7D251A9EDB8F1308f81940b828DCe86bD77F7`

**Network**: Ethereum Sepolia Testnet

**Entry Fee**: 0.01 ETH per ticket

**Prize Distribution**:
- 80% to winner
- 20% to platform maintenance

## 🎮 Getting Started

1. **Connect Wallet**: Click "Connect MetaMask" to link your Web3 wallet
2. **Select Numbers**: Choose three numbers between 1-50
3. **Choose Tickets**: Select how many tickets you want to purchase
4. **Enter Lottery**: Confirm the transaction to participate
5. **Wait for Draw**: Winner is selected automatically when criteria are met

## 📈 Live Statistics

The platform displays real-time information including:
- Current prize pool
- Number of participants
- Entry fee per ticket
- Lottery round number
- Recent winners and their prizes

## 🏆 Winner Selection

The system uses multiple sources of randomness for fair winner selection:
- Block timestamp
- Block difficulty
- Number of entries
- Round-specific secrets
- Transaction sender address

This multi-factor approach ensures true randomness and prevents manipulation.

## 🔍 Transparency & Verification

While maintaining participant privacy, the system provides full transparency through:
- **Public Prize Pool**: Real-time tracking of accumulated prizes
- **Entry Counts**: Number of participants per round
- **Winner History**: Complete record of all past winners
- **Transaction Records**: All blockchain transactions are publicly verifiable

## 🌐 Links

- **GitHub Repository**: https://github.com/AnjaliGoldner/AnonymousLottery
- **Live Platform**: https://anonymous-lottery.vercel.app/
- **Demo Video**: [AnonymousLottery.mp4]
- **Transaction Screenshots**: [(./draw winner Transaction Screenshots.png)(./enter lottery Transaction Screenshots.png)]

## 🔐 Security Features

- **No KYC Required**: Complete anonymity for all users
- **Encryption-First**: All sensitive data encrypted before blockchain storage
- **Smart Contract Security**: Audited contract logic with overflow protection
- **Randomness Verification**: Multiple entropy sources for fair draws
- **Automatic Execution**: No human intervention in winner selection

## 🎯 Use Cases

- **Privacy-Conscious Gaming**: For users who value anonymity
- **Transparent Lotteries**: Verifiable fairness without compromising privacy
- **Research Platform**: Demonstrating FHE applications in gaming
- **Educational Tool**: Learning blockchain privacy technologies

## 🔮 Future Enhancements

- Integration with production FHE libraries
- Multi-token support for various cryptocurrencies
- Enhanced UI/UX with advanced analytics
- Mobile application development
- Cross-chain compatibility

---

*Built with privacy-first principles and cutting-edge encryption technology to revolutionize online lottery systems.*