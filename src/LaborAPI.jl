module LaborAPI

using HTTP
using JSON3

const BASE_URL = "https://apiv3.dol.gov/v3/get/"

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
