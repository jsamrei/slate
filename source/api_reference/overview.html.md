**zillabyte API**
----
  The Zillabyte infrastructure provides handlers for a fully RESTful Application Programming Interface. The following overview explains portions of the API shared by every call.


  **Header structure**

  Successful API calls require the following parameters in the header:

  * `Authorization : AUTH_TOKEN` 

    This parameter utilizes your Zillabyte Authentication Token to associate the request with your account.

  * `Content-Type : application/json`

    This specifies the format of your input parameters, which will be JSON in this specification.


**URL structure**
  
  **https://www.api.zillabyte.com/method**

**Available Methods:**
  

  `GET` | `POST` | `DELETE` | `PUT`
  


**API Contents**  
### RPC
  * [RPC](/api_reference/rpc)