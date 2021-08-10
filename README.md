# LaborAPI

This package facilitates calling the DOL API. It defines a single function:

```
get(endpoint::String, params::Dict{String, Any})
```

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
