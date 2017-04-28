--Keybinds ini file setup
function setup_keys_defaults()
	local LIP = require ('LIP')
	
	if not LIP.exists('defaultKeys_player_1.ini') then
		local data =
		{
			keyboard =
			{
				leftKey = 'a',
				rightKey = 'd',
				jumpKey = 'space',
				activateKey = 'f',
				selectKey = 'return',
			},
			gamepad =
			{
				leftXAxis = 'leftx',
				leftYAxis = 'lefty',
				rightXAxis = 'rightx',
				rightYAxis = 'righty',
				
				triggerLeft = 'triggerleft',
				triggerRight = 'triggerright',
				
				gpActivate = 'a',
				gpBack = 'b',
				gpX = 'x',
				gpY = 'y'
			}
		}

		LIP.save('defaultKeys_player_1.ini', data)
	end
end