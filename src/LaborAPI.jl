module LaborAPI

using HTTP
using JSON3
using StructTypes

const BASE_URL = "https://apiv3.dol.gov/v3/get"

function get(endpoint::String, params::Dict{String, Union{String,Number}})
    url = BASE_URL * endpoint
    res = HTTP.get(
        url,
        ["Content-Type" => "application/json"],
        query=params,
        require_ssl_verification=false
    )
    json_str = String(res.body)
    JSON3.@generatetypes json_str
    return JSON3.read(json_str, JSONTypes.Root).data
end

end
