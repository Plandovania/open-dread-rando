Game.ImportLibrary("system/scripts/guilib.lua", false)
Game.ImportLibrary("system/scripts/input_handling.lua", false)

PracticeMod = PracticeMod or {
	ui = nil,
	menuOpen = false,
}

function PracticeMod.Init()
	Game.AddGUISF(1, "PracticeMod.Delayed_Init", "")
end

function PracticeMod.Delayed_Init()
	if PracticeMod.ui then
		PracticeMod.ui:Destroy()
	end

	PracticeMod.CreateGui()
	Game.AddGUISF(0.05, "PracticeMod.CheckInputs", "")
end

function PracticeMod.CreateGui()
	local ui = GUILib("PracticeMod_UI")

	ui:AddPanel("MainPanel", {
		X = 0.25,
		Y = 0.25,
		SizeX = 0.5,
		SizeY = 0.5,
	})
	ui:Hide()

	PracticeMod.ui = ui
end

function PracticeMod.CheckInputs()
	local delay = 0.05

	if Input.CheckInputs("L", "R", "STICKL") then
		PracticeMod.ToggleMenu()
		delay = 0.5
	end

	Game.AddGUISF(delay, "PracticeMod.CheckInputs", "")
end

function PracticeMod.ToggleMenu()
	if not PracticeMod.ui then
		return
	end

	local menuOpen = not PracticeMod.menuOpen

	PracticeMod.SetGamePaused(menuOpen)

	if menuOpen then
		PracticeMod.ui:Show()
	else
		PracticeMod.ui:Hide()
	end

	PracticeMod.menuOpen = menuOpen
end

function PracticeMod.SetGamePaused(paused)
	if Game.IsGamePaused() ~= paused then
		Game.TogglePause()
	end
end