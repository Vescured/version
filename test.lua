local HttpService = game:GetService("HttpService")

local apiURL = "https://raw.githubusercontent.com/Vescured/version/main/"

local supportedGamesURL = apiURL .. "supportedGames.json"
local loaderURL = apiURL .. "loader.lua"

local currentGameId = game.GameId

local supportedGames = request({
    Url = supportedGamesURL,
    Method = "GET"
})

local supportedGamesData = HttpService:JSONDecode(supportedGames.Body).games

local function load()
    loadstring(game:HttpGet(loaderURL))()
end

for _, value in pairs(supportedGamesData) do
	local gameId = value.id
    if gameId == currentGameId then
        load()
		break
    end
end
