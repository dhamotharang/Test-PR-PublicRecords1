#!node

const fs = require('fs');
const ut = require('./utility_lib.js');

let arg = process.argv.slice(2);
let per = 1;
let file = '_query_list.txt';

if (arg[0]) {
  if (isNaN(arg[0])) file = arg[0];
  else per = parseFloat(arg[0]);
}
if (arg[1]) {
  if (isNaN(arg[1])) file = arg[1];
  else per = parseFloat(arg[1]);
}


// main function
let main = async function() {
  let lines = await ut.getServices(per);
  let log = '';

  console.log('-----------------------------------------------');
  for (let item of lines) {
    console.log(item);
    log += item + '\n';
  }
  console.log('-----------------------------------------------\n');

  if (file) {
    console.log('Saving Query List: ' + file);
    try {
      fs.writeFileSync(file, log);
    }
    catch (error) {
      console.log('Error Writing: ' + file);
    }
  }
}

// run the main function
console.log('Getting Services:');
main();
