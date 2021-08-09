module LaborAPI

using HTTP
using JSON
using Tables

const BASE_URL = "https://apiv3.dol.gov/v3/get"

function get(endpoint::String, params::Dict{String, Union{String,Number}})
    url = BASE_URL * endpoint
    res = HTTP.get(
        url,
        ["Content-Type" => "application/json"],
        query=params,
        require_ssl_verification=false
    )
    dict = JSON.parse(String(res.body))["data"]
    colnames = collect(keys(dict[1]))
    data = [data[i][colnames[j]] for i in 1:length(data), j in 1:length(colnames)]
    return Tables.table(data, header=Symbol.(colnames))
end

end
