LUAGUI_NAME = 'Voice Rando'
LUAGUI_AUTH = 'Zurph'
LUAGUI_DESC = 'Randomizes Soras voice clips. Press L2+R2 to rerandomize.'

function _OnInit()
    if GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		OnPC = true
		vtbl = 0x2534EDB
        ConsolePrint('PC version detected. Running script.')
		ConsolePrint('Randomizing!')
		Rerandomize()
    elseif (GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301) and ENGINE_TYPE == "ENGINE" then --PCSX2
		OnPC = false
		vtbl = 0x1D0A92C
        ConsolePrint('PCSX2-EX detected. Running script.')
		ConsolePrint('Randomizing!')
		Rerandomize()
    end
end

function _OnFrame()
    randomizeVoice2()
end

function randomizeVoice2()
if OnPC == true then
	vtbl = 0x2534EDB
elseif OnPC == false then
	vtbl = 0x1D0A92C
end
	ranVoiceS = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F}
	--List of voice clips used in battle that are already "randomized" by the voice table. These are Voice1.
	SV1 = ranVoiceS[math.random(31)] --Grab a value from this array of 31 values, & randomly chooses to assign to variable SV1.
local vtbl_area = vtbl+0xC

if ReadByte(vtbl+0x140) == 0x03 then
	for i = 0, 23, 1 do --Runs 23 times.
			SV1 = ranVoiceS[math.random(31)] --Each time it runs, chooses a different random number.
			WriteByte(vtbl_area, SV1) --Then writes that random number.
				vtbl_area = vtbl_area+0xE --Updates location of next Voice location. Thankfully they're in consistent spots.
		end
	end
end

function Rerandomize()
--Need a better way in the future to randomize this in just one function. 
if OnPC == true then
	vtbl = 0x2534EDB
elseif OnPC == false then
	vtbl = 0x1D0A92C
end
	ranVoiceS = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F}
	SV1 = ranVoiceS[math.random(31)]
	local vtbl_area = vtbl+0xC
		ConsolePrint("DEBUG: Test Print!")
		for i = 0, 23, 1 do --Runs 23 times.
		SV1 = ranVoiceS[math.random(31)]
		WriteByte(vtbl_area, SV1)
			vtbl_area = vtbl_area+0xE 
			ConsolePrint(i)
	end
end