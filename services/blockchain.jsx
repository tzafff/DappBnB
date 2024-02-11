import { ethers } from "hardhat";
import address from '@/contracts/contractAddress.json';
import abi from '@/artifacts/contracts/DappBnbX.sol/DappBnbX.json';
import { globalActions } from '@/store/globalSlices';
import { store } from '@/store';

const  toWei = (num) => ethers.parseEther(num.toString());
const fromWei = (num) => ethers.formatEther(num);

let ethereum, tx;

if(typeof window !== 'undefined') ethereum = window.ethereum;

const getEthereumContracts = async () => {
  const accounts = await ethereum?.request?.({ method: 'eth_accounts'})

  if(accounts?.length > 0 ) {
    const provider = new ethers.BrowserProvider(ethereum);
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(address.dappBnbXContract, abi, signer)
  } else {

  }
}


