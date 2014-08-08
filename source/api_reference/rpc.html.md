**RPC Commands**
----

Components can be invoked via Remote Procedure Calls, allowing them be integrated into existing applications. See the [Quick Start - Components](/quickstart/components) page for a detailed overview on components.

----


**Submit RPC request**
----


**URL**

  /components/ID/execute

**Method**

   `POST`

**URL Params**

   `ID : integer`

**Data Params** 

  `rpc_inputs : [[string]]`

**Sample Call:**

  ``` bash
curl \
  -H "Content-Type:application/json" \
  -H "Authorization : AUTH_TOKEN" \
  -X POST "api.zillabyte.com/components/2182/execute" \
  -d '{"rpc_inputs" : [["http://www.zillabyte.com"]]}'
```

**Success Response:**

 * **Code:** 200 <br />
 * **Content:** 

    ``` bash
      { "status" : "sucess",
        "id" : "2182",
        "execute_ids" : { [\"http://www.zillabyte.com\"]":"f4c20c94-36a6-451e-9179-598ab4aa04c8"
        }
      }
      ```
 
**Error Response:**

 * **Code:** 401 UNAUTHORIZED <br />

  OR

 * **Code:** 500 UNACCESSABLE <br />



**Notes:**

  The `execute_ids` results correspond to the pending RPC execution requests. These IDs can be used to query the status and retrieve the results of the RPC.



----

**Retrieve RPC Status**
----


**URL**

  /components/ID/execute

**Method**

   `GET`

**URL Params**

   `ID=integer`

**Data Params** 

  `execute_ids=[string]`

**Success Response:**

 * **Code:** 200 <br />
 * **Content:** 
 
    ```bash
      { "status" : "success"
        "results": 
          { "6a1284ea-1b69-4a9f-acc3-c589c89e2e6b" : 
            { "status" : "complete", 
              "data" : { "COMPONENT_OUTPUT" : {COLUMN_1 : {DATA_1, "COLUMN_2" : "DATA_2"} }}
            }
          }
        }
      }
      ```
 
**Error Response:**

 * **Code:** 401 UNAUTHORIZED <br />

  OR

 * **Code:** 500 UNACCESSABLE <br />

**Sample Call:**

``` bash
  curl -H "Content-Type:application/json" \
  -H "Authorization : AUTH_TOKEN" \
  -X GET "api.zillabyte.com/components/2182/execute" \
  -d '{"execute_ids" : ["6a1284ea-1b69-4a9f-acc3-c589c89e2e6b"]}' \
  "api.zillabyte.com/components/ID/execute"

```

**Notes:**

The status of the RPC is `"running"` if it has yet to finish. If the status returns as `"complete"`, the `"data"` field will contain the data defined by your component's output `"COMPONENT_OUTPUT"`