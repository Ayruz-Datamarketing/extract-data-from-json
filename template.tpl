___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Extract Data From JSON",
  "categories": [
    "UTILITY"
  ],
  "description": "This tag helps you extract element from JSON object or valid JSON string by path (using dot-notation).",
  "containerContexts": [
    "SERVER"
  ],
  "brand": {
    "id": "github.com_ayruz-data-marketing",
    "displayName": "Ayruz-data-marketing"
  }
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "jsonInp",
    "displayName": "JSON Input",
    "simpleValueType": true,
    "help": "Valid JSON string or variable containing JSON object",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "target",
    "displayName": "Path to Element",
    "simpleValueType": true,
    "help": "eg.s: item.price, items[2].name",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "stringify",
    "checkboxText": "Convert Results to String Format",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___

const JSON = require('JSON');

let jsonInp = data.jsonInp || {};
let target = data.target || "";

if (typeof(jsonInp) === "string") {
    jsonInp = JSON.parse(jsonInp);
} 
 
let value = target.split('.').reduce(function(prev, curr) {

  let indexStart = curr.indexOf('[');
  let indexEnd = curr.indexOf(']');

  if (indexStart >=0 && indexEnd > indexStart) {

    let array = curr;
    curr = array.substring(0,indexStart);
    let arrIndex = array.substring(indexStart+1, indexEnd);
    
    if (curr != "")
      return prev && prev[curr][arrIndex];
    else 
      return prev && prev[arrIndex];
    
  } else return prev && prev[curr];

}, jsonInp);

if ((typeof(value) === "string") && data.stringify) value = JSON.stringify(value);

return value;


___TESTS___

scenarios: []


___NOTES___

Created on 6/22/2022, 7:37:27 PM


