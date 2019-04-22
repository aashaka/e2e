import {AccountRequest, BlockHashRequest, CodeRequest, StorageNodeClient, StorageRequest} from '@rainblock/protocol';
import {hashAsBigInt, HashType} from 'bigint-hash';
import * as fs from 'fs-extra';
import * as grpc from 'grpc';
import {RlpDecode, RlpList} from 'rlp-stream/build/src/rlp-stream';

import {EthereumAccount, rlpToEthereumAccount} from './utils';


const array = fs.readFileSync(__dirname + '/test_data/address0.txt')
                  .toString()
                  .split('\n');
let hrstart: [number, number];
let finished = 0;
const ops = Number(process.argv[2]);

const benchGetAccount =
      async (client: StorageNodeClient, addressString: string) => {
          const address = Buffer.from(addressString, 'hex');
          const request = new AccountRequest();
          request.setAddress(address);
          client.getAccount(request, (err, response) => {
                if (err) {
                        throw new Error('Error in getAccount rpc');
                      }
                finished += 1;
                if (finished === ops) {
                        const hrend = process.hrtime(hrstart);
                        console.log('GetAccountOps: ', ops);
                        console.log('Time(s): ', hrend[0] + hrend[1] / 1000000000);
                      }
              });
      };

const runTestClient = async (host: string, port: string) => {
    const storageSocket = host + ':' + port;
    const client =
          new StorageNodeClient(storageSocket, grpc.credentials.createInsecure());
    hrstart = process.hrtime();
    for (let i = 0; i < ops; i++) {
          const len = array.length;
          benchGetAccount(client, array[i % len]);
        }
};

const callClient = () => {
    // Benchmarking shard 0
    const host = '0.0.0.0';
     const port = '50051';
       console.log('\nStarting client to connect server at:' + host + ':' + port);
         runTestClient(host, port);
         };

          callClient();
