const cp = require('child_process');
const fs = require('fs');
const fetch = require('node-fetch');
const xjs = require('xml-js');
const glib = require('./att_graph_lib.js');


// utility functions
// ----------------------------------------------
let checkObject = function(obj) {
  return typeof obj === 'object' && obj !== null;
};

let findFirstKey = function(obj, key) {
  let out = null;

  if (checkObject(obj))
  {
    let karr = Object.keys(obj);
    if (karr.find(kk => kk == key)) out = obj[key];
    else {
      for (const kk of karr) {
        let tmp = findFirstKey(obj[kk], key);
        if (tmp) { out = tmp; break; }
      }
    }
  }

  return out;
};

let getDateString = function () {
  let d = new Date();
  return d.toISOString();
};
// ----------------------------------------------

// Web Utilities
// ----------------------------------------------
let soapCall = async function(url, request_txt, timeout = 8000) {
  let opt = { 
    method: 'post', 
    body: request_txt, 
    headers: { 'Content-Type': 'text/xml' }, 
  };
  let result = {
    status_ok: false, 
    status: { val: 0, text: 'soapcall error' }, 
    response: '', 
  };

  console.log('Sending Request to: ' + url);

  try {
    let response = await fetch(url, opt);
    let rtxt = await response.text();
    
    console.log('Soapcall response');

    // assemble result
    result = {
      status_ok: response.ok, 
      status: { val: response.status, text: response.statusText }, 
      response: rtxt, 
    };

    if (!result.status_ok) {
      console.log('Error: Request Failed');
    }
  }
  catch (error) {
    result.status.text = error;
    console.log('Error: Request Failed');
  }

  return result;
}

let apiCall = async function(url, token = '', timeout = 8000) {
  let hdr = { 'Content-Type': 'application/json' };
  if (token) hdr['Private-Token'] = token;

  let opt = { 
    method: 'get', 
    headers: hdr, 
  };
  let result = {
    status_ok: false, 
    status: { val: 0, text: 'soapcall error' }, 
    response: '', 
  };

  console.log('Sending API Request to: ' + url);

  try {
    let response = await fetch(url, opt);
    let rtxt = await response.text();
    
    console.log('API response');

    // assemble result
    result = {
      status_ok: response.ok, 
      status: { val: response.status, text: response.statusText }, 
      response: rtxt, 
    };

    if (!result.status_ok) {
      console.log('Error: Request Failed: ' + response.status + ' -- ' + response.statusText);
    }
  }
  catch (error) {
    result.status.text = error;
    console.log('Error: Request Failed: ' + error);
  }

  return result;
}
// ------------------------------------------

// Service Fetching
// ----------------------------------------------
let dedupServices = function(list) {
  let out = [];
  let last = '';
  
  for (let item of list) {
    if (item.toLowerCase() != last.toLowerCase()) out.push(item);
    last = item;
  }
  return out;
}

let getServicesFromFile = function(filename, filter = 1) {
  let out = [];
  console.log('Fetching Services From File: ' + filename);
  
  try {
    let txt = fs.readFileSync(filename, { encoding: 'utf8' });
    if (txt) out = txt.split('\n').map((item) => item.trim()).filter(item => item);
  }
  catch (err) {
    console.log('Error Reading File: ' + filename)
  }

  // optionally filter a random subset
  if (filter < 1) out = out.filter(() => Math.random() < filter);
  
  return out;
}

let getServices = async function(filter = 1) {
  const server_url = 'http://uspr-dopsservices.risk.regn.net/demodopsservice.asmx';
  const server_req = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:lex="http://lexisnexis.com/"><soapenv:Header/><soapenv:Body><lex:GetQueryList><lex:location>B</lex:location><lex:environment></lex:environment><lex:cluster></lex:cluster></lex:GetQueryList></soapenv:Body></soapenv:Envelope>';
  let out = [];
  console.log('Fetching Services List...');
  
  let res = await soapCall(server_url, server_req);
  if (res.status_ok) {
    let obj = xjs.xml2js(res.response, { compact: true, trim: true });
    let tmp = findFirstKey(obj, 'dquery');
    let arr = (tmp && Array.isArray(tmp)) ? tmp : [];
    
    console.log('Services Response OK: ' + arr.length);
    arr.forEach((item) => out.push(item.queryname._text));
  }
  else console.log('Services Request Failed');
  
  // optionally filter a random subset
  if (filter < 1) out = out.filter(() => Math.random() < filter);
  
  return dedupServices(out);
}

let getExceptions = function(fname) {
  let exceptions = new Set();
  let svcs = getServicesFromFile(fname);

  for (let item of svcs) {
    let tmp = item.toLowerCase();
    exceptions.add(tmp);
  }
  console.log('Loaded Exceptions: ' + exceptions.size);

  return exceptions;
}
// ------------------------------------------

// Merge Request
// ----------------------------------------------
let getCodeList = function(text, code) {
  let t2 = text.replace(/\r\n/g, '\n');
  let lines = t2.split('\n');
  let inside = false;
  let arr = [];

  for (let line of lines) {
    if (line.startsWith("<!--") || line.startsWith("**") || 
      line.trim() == '') {}
    else if (line.includes('<code id=\"' + code + '\"')) inside = true;
    else if (line.includes('</code>')) inside = false;
    else if (inside) arr.push(line.trim());
  }

  return arr;
}

let toAtt = function(path) {
  let tmp = path.toLowerCase().split('/');
  let out = '';

  for (let i=0; i < tmp.length; i++) {
    let str = tmp[i];
    if (i == tmp.length - 1) {
      if (str.endsWith('.ecl')) str = str.slice(0, -4);
      out = out + str;
    }
    else out = out + str + '.';
  }
  return out;
}

let getMergeRequestInfo = async function(mr_id) {
  let url = "https://bctwpprroxie301.risk.regn.net/roxiedevapi/git/merge-request/" + mr_id;
  let out = null;

  let res = await apiCall(url);
  if (res.status_ok) {
    try {
      let rr = JSON.parse(res.response);

      out = { deploy_list: [], change_list: [] };
      if (rr['query-deploy-list']) out.deploy_list = rr['query-deploy-list'];
      if (rr['changed-attribute-list']) out.change_list = rr['changed-attribute-list'];
    }
    catch (error) {
      console.log('Unable to parse Merge Request Info API response');
    }
  }
  else console.log('Merge Request Merge Request Info API Call Failed');

  return out;
}

let getMergeRequest = async function(proj_id, mr_id, token = '', 
  changes = false) {
  let url = "https://gitlab.ins.risk.regn.net/api/v4/projects/" + proj_id + 
    "/merge_requests/" + mr_id;
  let out = null;

  if (changes) url += '/changes';

  let res = await apiCall(url, token);
  if (res.status_ok) {
    try {
      let rdata = {};

      out = JSON.parse(res.response);

      // any query lists from description
      let desc = out.description;
      if (desc) {
        rdata.deploy_list = getCodeList(desc, 'd');
        rdata.retire_list = getCodeList(desc, 'r');
      }

      // if changes were fetched, create a convenient change list
      let ch = out.changes;
      if (ch) {
        let carr = [];
        for (let item of ch) {
          let path = item.new_path;
          if (path) carr.push(toAtt(path));
        }
        rdata.change_list = carr;
      }
      out.roxie_data = rdata;
    }
    catch (error) {
      console.log('Unable to parse API response');
    }
  }
  else console.log('Merge Request API Call Failed');

  return out;
}
// ------------------------------------------

// Dependency Graph
// ------------------------------------------
let loadRawAttributeInfo = async function() {
  const url = 'https://bctwpprroxie301.risk.regn.net/ecldocsjson/roxiedev.json';
  let out = null;

  console.log('Fetching Attribute Info From: ' + url);
  let res = await apiCall(url);

  if (res.status_ok) {
    console.log('Attribute Info Loaded');
    try {
      out = JSON.parse(res.response);
    }
    catch (error) {
      console.log('Error Parsing Attribute Info');
      out = null;
    }
  }
  else {
    console.log('Attribute Info Load Failed');
  }

  return out;
}

let loadAttributeGraph = async function() {
  let info = await loadRawAttributeInfo();
  let graph = null;

  if (info) {
    console.log('Creating Attribute Graph');
    let obj = glib.generate_map_new(info);
    console.log('Attribute Graph Created');

    if (obj.attribute_map) graph = obj.attribute_map;
  }

  return graph;
}

let findDependencies = async function(attributes) {
  let graph = await loadAttributeGraph();
  let deps = [];
  let out = null;

  if (graph) {
    console.log('Finding Dependencies for ' + attributes.length + ' Attributes');

    glib.clear_map(graph);
    for (let att of attributes) {
      let aa = att.trim().toLowerCase();
      if (aa) glib.markup_services(graph, aa, deps);
    }
    console.log('Found ' + deps.length + ' Dependencies');
    
    // since we have data, we can consider the output correct - even if empty
    out = [];

    // convert to output format
    for (let obj of deps) {
      out.push(obj.module + '.' + obj.attribute);
    }
  }

  return out;
}
// ------------------------------------------

let isLibrary = function(str) {
  let arr = str.split('.');
  let is_lib = false;

  if (arr.length > 0) {
    let el = arr[arr.length - 1];
    if (el.toLowerCase().search('lib_') == 0) is_lib = true;
  }

  return is_lib;
}

// match attribute name to (case-correct) file path
let findPath = function(str, workpath) {
  let arr = str.split('.');
  let pp = workpath;
  let find = (str, dir) => {
    let tmp = str.toLowerCase();
    let ret = null;
    
    for (let item of dir) {
      if (item.toLowerCase() == tmp) { ret = item; break; }
    }
    return ret;
  };
  
  // add ECL suffix to final file name
  if (arr.length == 0) return null;
  else arr[arr.length - 1] += '.ecl';
  
  for (let item of arr) {
    let dir = [];
    try { dir = fs.readdirSync(pp); } catch (error) {}
    
    let name = find(item, dir);
    if (name) pp = pp + '/' + name;
    else return null;
  }
  return pp;
}

// count warnings / errors in a results string
let countExceptions = function(text) {
  let regex_e = /: error [A-Z]\d+:/g;
  let regex_w = /: warning [A-Z]\d+:/g;
  let lines = text.split('\n');
  let out = { errors: 0, warnings: 0 };

  for (let item of lines) {
    if (regex_e.test(item)) out.errors++;
    if (regex_w.test(item)) out.warnings++;
  }

  return out;
};

// perform syntax check
let syntax_check_async = function(path, workpath, use_fast = true) {
  return new Promise(resolve => {
    let args = [
      '-syntax', 
      '--nostdinc', 
      '-I', 
      workpath, 
      '-legacy', 
      path
    ];
    let out = { ok: false, status: 0, stdout: '', stderr: '' };
  
    // optionally use fastsyntax
    if (use_fast) args.splice(1, 0, '--fastsyntax');

    let proc = cp.execFile('eclcc', args, (error, stdout, stderr) => {
      out.stdout = (stdout) ? stdout.trim() : '';
      out.stderr = (stderr) ? stderr.trim() : '';

      if (error) {
        let ex = countExceptions(out.stderr);

        // eclcc may return an error code but no errors - in that case mark as ok
        out.ok = (ex.errors <= 0);
        out.status = error.status;
      }
      else out.ok = true;

      resolve(out);
    });
  });
}

// export warning info to file
let exportWarnings = function(warn, file) {
  let log = 'Syntax Check Warnings: ' + getDateString() + '\n\n';

  for (let item of warn) {
    log += '[[ ' + item.query + ' ]]\n';
    log += '----------------------------------------------------------\n';
    log += item.res.stderr;
    log += '\n----------------------------------------------------------\n\n';
  }
  
  try {
    fs.writeFileSync(file, log);
    console.log('Warnings Exported: ' + file);
  }
  catch (error) {
    console.log('Unable to Write Warnings File: ' + file);
  }
}

// exported functions
module.exports = {
  getServices: getServices, 
  getServicesFromFile: getServicesFromFile, 
  getMergeRequest: getMergeRequest, 
  getMergeRequestInfo: getMergeRequestInfo, 
  getExceptions: getExceptions, 
  isLibrary: isLibrary, 
  findPath: findPath, 
  getDateString: getDateString, 
  syntax_check_async: syntax_check_async, 
  exportWarnings: exportWarnings, 
  findDependencies: findDependencies, 
}
