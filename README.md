# Starknet Counter Workshop — Completion

I have completed all the steps successfully and deployed the contract.  
**Contract address:** `0x48495997b81e146f0e0dc2a744f93895015bb397ce55d77103805e67951eebd` on Starknet Sepolia.

*(Although, Step 11 wasn't passing consistently even though I did the same thing every time. So I used the specific subpackage from the dependecy which worked every time in it.)*

## How to deploy

1. Create a file in the project's root folder called `.env`.
2. Export the private key of your funded Testnet wallet and paste it into the `.env` file using the key `DEPLOYER_PRIVATE_KEY`.
   ```bash
   DEPLOYER_PRIVATE_KEY=<WALLET_PRIVATE_KEY>
   ```
3. Export the public key of the wallet and paste it into the `.env` file using the key `DEPLOYER_ADDRESS`.
   ```bash
   DEPLOYER_ADDRESS=<WALLET_PUBLIC_ADDRESS>
   ```
4. Add the following line containing the Blast RPC endpoint in the `.env` file:
   ```bash
   RPC_ENDPOINT=https://starknet-sepolia.public.blastapi.io/
   ```
5. From the project's root folder run:
   ```bash
   $ npm install
   $ npm run deploy
   ```
