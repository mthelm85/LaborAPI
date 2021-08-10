module LaborAPI

using HTTP
using JSON3

const BASE_URL = "https://apiv3.dol.gov/v3/get/"
"""
    get(endpoint::String, params::Dict{String, Any})

Call the DOL API at the provided endpoint and with the provided parameters.
The `params` dictionary must contain at a minimum your API key.

# Examples

```
using LaborAPI

params = Dict(
    "X-API-KEY" => "adslfj3987234kjaf987fdas",
    "fields" => "case_id, flsa_violtn_cnt"
)

endpoint = "whd/wh_enforcement"

res = LaborAPI.get(endpoint, params)
```
"""
function get(endpoint::String, params::Dict{String, Any}) 
    url = BASE_URL * endpoint
    try
        res = HTTP.get(
            url,
            ["Content-Type" => "application/json"],
            query=params,
            require_ssl_verification=false
        )
        if HTTP.status(res) == 200
            json_str = String(res.body)
            return JSON3.read(json_str)
        else
            return error("ERROR: Expected status code 200 but got status code: $(HTTP.status(res))")
        end
    catch e
        return e
    end
end


end
