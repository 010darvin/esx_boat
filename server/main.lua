MySQL.ready(function()
	ParkBoats()
end)

function ParkBoats()
	MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = false AND type = @type', {
		['@type'] = 'boat'
	}, function (rowsChanged)
		if rowsChanged > 0 then
			print(('[^2INFO^7] Stored ^5%s^7 %s !'):format(rowsChanged, rowsChanged > 1 and 'boats' or 'boat'))
		end
	end)
end

ESX.RegisterServerCallback('esx_boat:buyBoat', function(source, cb, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price   = getPriceFromModel(vehicleProps.model)

	-- vehicle model not found
	if price == 0 then
		print(('[^2INFO^7] Player ^5%s^7 Attempted To Exploit Shop'):format(xPlayer.source))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price, "Boat Purchase")

			MySQL.update('INSERT INTO owned_vehicles (owner, plate, vehicle, type, `stored`) VALUES (@owner, @plate, @vehicle, @type, @stored)', {
				['@owner']   = xPlayer.identifier,
				['@plate']   = vehicleProps.plate,
				['@vehicle'] = json.encode(vehicleProps),
				['@type']    = 'boat',
				['@stored']  = true
			}, function(rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

RegisterServerEvent('esx_boat:takeOutVehicle')
AddEventHandler('esx_boat:takeOutVehicle', function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.update('UPDATE owned_vehicles SET `stored` = @stored WHERE owner = @owner AND plate = @plate', {
		['@stored'] = false,
		['@owner']  = xPlayer.identifier,
		['@plate']  = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('[^2INFO^7] Player ^5%s^7 Attempted To Exploit Garage'):format(xPlayer.source))
		end
	end)
end)

ESX.RegisterServerCallback('esx_boat:storeVehicle', function (source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.update('UPDATE owned_vehicles SET `stored` = @stored WHERE owner = @owner AND plate = @plate', {
		['@stored'] = true,
		['@owner']  = xPlayer.identifier,
		['@plate']  = plate
	}, function(rowsChanged)
		cb(rowsChanged)
	end)
end)

ESX.RegisterServerCallback('esx_boat:getGarage', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT vehicle FROM owned_vehicles WHERE owner = @owner AND type = @type AND `stored` = @stored', {
		['@owner']  = xPlayer.identifier,
		['@type']   = 'boat',
		['@stored'] = true
	}, function(result)
		local vehicles = {}

		for i=1, #result, 1 do
			table.insert(vehicles, result[i].vehicle)
		end

		cb(vehicles)
	end)
end)

ESX.RegisterServerCallback('esx_boat:buyBoatLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice, "Boat License Purchase")

		TriggerEvent('esx_license:addLicense', source, 'boat', function()
			cb(true)
		end)
	else
		cb(false)
	end
end)

function getPriceFromModel(model)
	for k,v in ipairs(Config.Vehicles) do
		if joaat(v.model) == model then
			return v.price
		end
	end

	return 0
end
end 
end server admin 
end admin-leitung 
end car Scania R570 G&J
end car F-15 Silent Eagle
end car KAI KF-21 Boramae
end car AS332 Super Puma LA (LS) County Sheriff
end car Su-35S Flanker-E [Custom weapons
end car B-2A Spirit Stealth Bomber
end car DDG-151 Nathan James [Working gun
end car Boeing 727-200
end car Antonov AN-225 Mriya 
end car UH-1Y Venom 1.1
end car UH-1H Iroquois NASA
end car Boeing 747 Space Shuttle Carrier
end car S-70A Firehawk Fire Fighting Helicopter
end car Apache AH Mk 1 British Armed Forces
end car Airbus A321 Neo [Add-On/14 liveries] 1.0
end car Bugatti Chiron 2017
end car BMW M760i 2017
end car Maybach S650 2019 for
end car Rolls-Royce Cullinan Black
end car Mercedes-Benz E63s W213
end car Nissan GTR-R35 
end car Lamborghini Huracan EVO2 2022
end car Audi RS6 
end car Simon Motorsport's Ferrari 458 Italia Liberty
end car BMW M3 F80 POLICE NM-STYL
end car BMW car M8 Prior Police NM-Style for 
end car Dare Sandy Shores Pd Car
end doorlock script 
coords umkleide  x:461 y:-996 Z:30
coords büro x:451 y:-990 z:30

