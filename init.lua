addMaid(vape)
gui = Instance.new('ScreenGui')
gui.Name = randomString()
gui.DisplayOrder = 9999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.IgnoreGuiInset = true

if vape.ThreadFix then
	local holder = Instance.new('Folder')
	holder.Parent = cloneref(game:GetService('CoreGui'))
	gui.OnTopOfCoreBlur = true
	gui.Parent = (gethui and gethui()) or cloneref(game:GetService('CoreGui'))
	vape.holder = holder
else
	gui.Parent = cloneref(game:GetService('Players')).LocalPlayer.PlayerGui
	gui.ResetOnSpawn = false
	vape.holder = gui
end
vape.gui = gui

scaledgui = Instance.new('Frame')
scaledgui.BackgroundTransparency = 1
scaledgui.Name = '缩放界面'
scaledgui.Size = UDim2.fromScale(1, 1)
scaledgui.Parent = gui
clickgui = Instance.new('Frame')
clickgui.BackgroundTransparency = 1
clickgui.Name = '点击界面'
clickgui.Size = UDim2.fromScale(1, 1)
clickgui.Visible = false
clickgui.Parent = scaledgui
local scarcitybanner = Instance.new('TextLabel')
scarcitybanner.BackgroundTransparency = 1
scarcitybanner.FontFace = uipallet.Font
scarcitybanner.Position = UDim2.fromScale(0, 0.97)
scarcitybanner.Size = UDim2.fromScale(1, 0.018)
scarcitybanner.Text = '所有更新日志和游戏支持都在Discord,点击Discord图标加入'
scarcitybanner.TextColor3 = Color3.new(1, 1, 1)
scarcitybanner.TextScaled = true
scarcitybanner.TextStrokeTransparency = 0.5
scarcitybanner.Parent = clickgui
local modal = Instance.new('TextButton')
modal.BackgroundTransparency = 1
modal.Modal = true
modal.Text = ''
modal.Parent = clickgui
local cursor = Instance.new('ImageLabel')
cursor.BackgroundTransparency = 1
cursor.Image = 'rbxasset://textures/Cursors/KeyboardMouse/ArrowFarCursor.png'
cursor.Size = UDim2.fromOffset(64, 64)
cursor.Visible = false
cursor.Parent = gui
notifications = Instance.new('Folder')
notifications.Name = '通知'
notifications.Parent = scaledgui
tooltip = Instance.new('TextLabel')
tooltip.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
tooltip.FontFace = uipallet.Font
tooltip.Position = UDim2.fromScale(-1, -1)
tooltip.RichText = true
tooltip.Text = ''
tooltip.TextColor3 = color.Dark(uipallet.Text, 0.16)
tooltip.TextSize = 12
tooltip.Visible = false
tooltip.ZIndex = 5
tooltip.Parent = scaledgui
toolblur = addBlur(tooltip)
addCorner(tooltip)
scale = Instance.new('UIScale')
scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.6)
scale.Parent = scaledgui
scaledgui.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale)
components.GUI({})

vape:CreateCategory({
	Name = '战斗',
	Icon = getvapeasset('newvape/assets/new/combat.png'),
	Size = UDim2.fromOffset(13, 14)
})
vape:CreateCategory({
	Name = '明显作弊',
	Icon = getvapeasset('newvape/assets/new/blatant.png'),
	Size = UDim2.fromOffset(14, 14)
})
vape:CreateCategory({
	Name = '渲染',
	Icon = getvapeasset('newvape/assets/new/render.png'),
	Size = UDim2.fromOffset(15, 14)
})
vape:CreateCategory({
	Name = '实用工具',
	Icon = getvapeasset('newvape/assets/new/utility.png'),
	Size = UDim2.fromOffset(15, 14)
})
vape:CreateCategory({
	Name = '世界',
	Icon = getvapeasset('newvape/assets/new/world.png'),
	Size = UDim2.fromOffset(14, 14)
})
vape:CreateCategory({
	Name = '物品栏',
	Icon = getvapeasset('newvape/assets/new/inventory.png'),
	Size = UDim2.fromOffset(15, 14)
})
vape.Categories.Main:CreateDivider({
	Text = 'misc'
})

--[[
	Friends
]]
do
	local friends
	local friendscolor = {
		Hue = 1,
		Sat = 1,
		Value = 1
	}

	friends = vape:CreateCategoryList({
		Name = '好友',
		Icon = getvapeasset('newvape/assets/new/friends.png'),
		Size = UDim2.fromOffset(17, 16),
		Placeholder = 'Roblox用户名',
		Color = Color3.fromRGB(5, 134, 105),
		Function = function()
			friends.Update:Fire()
			friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
		end
	})
	friends.Update = Instance.new('BindableEvent')
	friends.ColorUpdate = Instance.new('BindableEvent')
	friends:CreateToggle({
		Name = '重新着色视觉',
		Darker = true,
		Default = true,
		Function = function()
			friends.Update:Fire()
			friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
		end
	})
	friendscolor = friends:CreateColorSlider({
		Name = '好友颜色',
		Darker = true,
		Function = function(hue, sat, val)
			for _, v in friends.Object.Children:GetChildren() do
				local dot = v:FindFirstChild('Dot')
				if dot and dot.BackgroundColor3 ~= color.Light(uipallet.Main, 0.37) then
					dot.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
					dot.Dot.BackgroundColor3 = dot.BackgroundColor3
				end
			end

			friends.ColorUpdate:Fire(hue, sat, val)
		end
	})
	friends:CreateToggle({
		Name = '使用好友列表',
		Darker = true,
		Default = true,
		Function = function()
			friends.Update:Fire()
			friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
		end
	})
	vape:Clean(friends.Update)
	vape:Clean(friends.ColorUpdate)
end

--[[
	Profiles
]]
vape:CreateCategoryList({
	Name = '配置文件',
	Icon = getvapeasset('newvape/assets/new/profiles.png'),
	Size = UDim2.fromOffset(17, 10),
	Position = UDim2.fromOffset(12, 16),
	Placeholder = '输入名称',
	Profiles = true
})

--[[
	Targets
]]
local targets
targets = vape:CreateCategoryList({
	Name = '目标',
	Icon = getvapeasset('newvape/assets/new/friends.png'),
	Size = UDim2.fromOffset(17, 16),
	Placeholder = 'Roblox用户名',
	Function = function()
		targets.Update:Fire()
	end
})
targets.Update = Instance.new('BindableEvent')
vape:Clean(targets.Update)

components.LegitWindow()
vape.SearchBar = components.SearchBar()
vape.Categories.Main:CreateOverlayBar()

--[[
	General Settings
]]

local general = vape.Categories.Main.Settings:CreateSettingsPane({Name = '通用'})
local settingConnections = {}
vape.MultiKeybind = general:CreateToggle({
	Name = '启用多键绑定',
	Tooltip = '允许多个按键绑定到模块(如G+H)'
})
general:CreateToggle({
	Name = '允许设置按键绑定',
	Function = function(callback)
		if callback then
			for _, container in {vape.Modules, vape.Legit.Modules} do
				for _, module in container do
					for _, component in module.Options do
						if component.Type == 'Toggle' then
							local bind = components.Bind({
								Module = true
							}, nil, component)
							bind.Object.Position = UDim2.new(1, -40, 0, 5)

							table.insert(settingConnections, bind.Triggered:Connect(function(isDown)
								if bind.Hold then
									if component.Enabled ~= isDown then
										if vape.SettingToggleNotifications.Enabled then
											vape:CreateNotification(module.Name, component.Name..' '..(not component.Enabled and "<font color='#00AA00'>ON</font>" or "<font color='#FF5A5A'>OFF</font>"), 1.5)
										end

										component:Toggle()
									end
								else
									if vape.SettingToggleNotifications.Enabled then
										vape:CreateNotification(module.Name, component.Name..' '..(not component.Enabled and "<font color='#00AA00'>ON</font>" or "<font color='#FF5A5A'>OFF</font>"), 1.5)
									end

									component:Toggle()
								end
							end))

							table.insert(settingConnections, component.Object.MouseEnter:Connect(function()
								bind:SetVisible(true)
							end))

							table.insert(settingConnections, component.Object.MouseLeave:Connect(function()
								bind:SetVisible(false)
							end))
						end
					end
				end
			end
		else
			for _, container in {vape.Modules, vape.Legit.Modules} do
				for _, module in container do
					for _, component in module.Options do
						if component.Bind then
							component.Bind:Destroy()
						end
					end
				end
			end

			for _, connection in settingConnections do
				connection:Disconnect()
			end
			table.clear(settingConnections)
		end
	end,
	Tooltip = '悬停在开关设置上以绑定按键'
})

general:CreateButton({
	Name = '重置当前配置',
	Function = function()
	vape.Save = function() end
		if isfile('newvape/profiles/'..vape.Profile..vape.Place..'.txt') and delfile then
			delfile('newvape/profiles/'..vape.Profile..vape.Place..'.txt')
		end

		shared.vapereload = true
		if shared.VapeDeveloper then
			loadstring(readfile('newvape/loader.lua'), 'loader')()
		else
			loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeCompiled/'..readfile('newvape/profiles/commit.txt')..'/loader.lua', true))()
		end
	end,
	Tooltip = '这将设置你的配置文件为Vape默认设置'
})

general:CreateButton({
	Name = '自我销毁',
	Function = function()
		vape:Uninject()
	end,
	Tooltip = '从当前游戏移除Vape'
})

general:CreateButton({
	Name = '重新注入',
	Function = function()
		shared.vapereload = true
		if shared.VapeDeveloper then
			loadstring(readfile('newvape/loader.lua'), 'loader')()
		else
			loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeCompiled/'..readfile('newvape/profiles/commit.txt')..'/loader.lua', true))()
		end
	end,
	Tooltip = '重新加载Vape用于调试'
})

--[[
	Module Settings
]]

local modules = vape.Categories.Main.Settings:CreateSettingsPane({Name = '模块'})
modules:CreateToggle({
	Name = '按服务器分队',
	Tooltip = '忽略服务器指定的队友',
	Default = true,
	Function = function()
		if vape.Libraries.entity and vape.Libraries.entity.Running then
			vape.Libraries.entity.refresh()
		end
	end
})

modules:CreateToggle({
	Name = '使用队伍颜色',
	Tooltip = '在渲染模块中使用玩家的队伍颜色属性',
	Default = true,
	Function = function()
		if vape.Libraries.entity and vape.Libraries.entity.Running then
			vape.Libraries.entity.refresh()
		end
	end
})

--[[
	GUI Settings
]]

local guipane = vape.Categories.Main.Settings:CreateSettingsPane({Name = '界面'})
vape.Blur = guipane:CreateToggle({
	Name = '模糊背景',
	Function = function()
		vape:BlurCheck()
	end,
	Default = true,
	Tooltip = '模糊界面背景'
})

guipane:CreateToggle({
	Name = '界面绑定指示器',
	Default = true,
	Tooltip = '注入后显示界面提示信息\n例如:'按右Shift打开界面''
})

guipane:CreateToggle({
	Name = '显示工具提示',
	Function = function(enabled)
		tooltip.Visible = false
		toolblur.Enabled = enabled
	end,
	Default = true,
	Tooltip = '切换这些的可见性'
})

guipane:CreateToggle({
	Name = '显示合法模式',
	Function = function(enabled)
		clickgui.Search.Legit.Visible = enabled
		clickgui.Search.LegitDivider.Visible = enabled
		clickgui.Search.TextBox.Size = UDim2.new(1, enabled and -50 or -10, 0, 37)
		clickgui.Search.TextBox.Position = UDim2.fromOffset(enabled and 50 or 10, 0)
	end,
	Default = true,
	Tooltip = '显示切换到合法菜单的按钮'
})

local ScaleSlider = {Object = {}, Value = 1}
vape.Scale = guipane:CreateToggle({
	Name = '自动缩放',
	Default = true,
	Function = function(callback)
		ScaleSlider.Object.Visible = not callback
		if callback then
			--scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.6)
		else
			scale.Scale = ScaleSlider.Value
		end
	end,
	Tooltip = '根据屏幕分辨率自动缩放界面'
})

ScaleSlider = guipane:CreateSlider({
	Name = '缩放',
	Min = 0.1,
	Max = 2,
	Decimal = 10,
	Function = function(val, final)
		if final and not vape.Scale.Enabled then
			scale.Scale = val
		end
	end,
	Default = 1,
	Darker = true,
	Visible = false
})

vape.RainbowSpeed = guipane:CreateSlider({
	Name = '彩虹速度',
	Min = 0.1,
	Max = 10,
	Decimal = 10,
	Default = 1,
	Tooltip = '调整彩虹值变化速度'
})

vape.RainbowUpdateSpeed = guipane:CreateSlider({
	Name = '彩虹更新频率',
	Min = 1,
	Max = 144,
	Default = 60,
	Tooltip = '调整彩虹值更新频率',
	Suffix = '赫兹'
})

--[[guipane:CreateDropdown({
	Name = '界面主题',
	List = inputService.TouchEnabled and {'new', 'old'} or {'new', 'old', 'rise'},
	Function = function(val, mouse)
		if mouse then
			writefile('newvape/profiles/gui.txt', val)
			shared.vapereload = true
			if shared.VapeDeveloper then
				loadstring(readfile('newvape/loader.lua'), 'loader')()
			else
				loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeCompiled/'..readfile('newvape/profiles/commit.txt')..'/loader.lua', true))()
			end
		end
	end,
	Tooltip = 'new - V4.05以来的最新Vape主题\nold - V4.05之前的Vape主题\nrise - Rise 6.0'
})]]

guipane:CreateDropdown({
	Name = '搜索栏样式',
	List = {'Floating', 'None'},
	Default = 'Floating',
	Function = function(value)
		vape.SearchBar.Object.Visible = value == 'Floating'
	end,
	Tooltip = '切换搜索栏样式'
})

vape.RainbowMode = guipane:CreateDropdown({
	Name = '彩虹模式',
	List = {'Normal', 'Gradient', 'Retro'},
	Tooltip = '普通 - 平滑颜色渐变\n渐变 - 渐变色过渡\n复古 - 静态颜色'
})

guipane:CreateButton({
	Name = '重置界面位置',
	Function = function()
		for _, category in vape.Categories do
			category.Object.Position = UDim2.fromOffset(6, 42)
		end
	end,
	Tooltip = '这将重置你的界面为默认'
})

guipane:CreateButton({
	Name = '排序界面',
	Function = function()
		local priority = {
			GUICategory = 1,
			CombatCategory = 2,
			BlatantCategory = 3,
			RenderCategory = 4,
			UtilityCategory = 5,
			WorldCategory = 6,
			InventoryCategory = 7,
			FriendsCategory = 8,
			ProfilesCategory = 9
		}

		local categories = {}
		for _, category in vape.Categories do
			if category.Type ~= 'Overlay' then
				table.insert(categories, category)
			end
		end

		table.sort(categories, function(a, b)
			return (priority[a.Object.Name] or 99) < (priority[b.Object.Name] or 99)
		end)

		local index = 0
		for _, category in categories do
			if category.Object.Visible then
				category.Object.Position = UDim2.fromOffset(6 + (index % 8 * 230), 60 + (index > 7 and 360 or 0))
				index += 1
			end
		end
	end,
	Tooltip = '按分类顺序排序界面'
})

--[[
	Notification Settings
]]

local notifpane = vape.Categories.Main.Settings:CreateSettingsPane({Name = '通知'})
vape.Notifications = notifpane:CreateToggle({
	Name = '通知',
	Function = function(enabled)
		if vape.ToggleNotifications.Object then
			vape.ToggleNotifications.Object.Visible = enabled
		end

		if vape.SettingToggleNotifications.Object then
			vape.SettingToggleNotifications.Object.Visible = enabled
		end
	end,
	Tooltip = '显示通知',
	Default = true
})

vape.ToggleNotifications = notifpane:CreateToggle({
	Name = '切换提醒',
	Tooltip = '模块启用/禁用时通知你',
	Default = true,
	Darker = true
})
vape.SettingToggleNotifications = notifpane:CreateToggle({
	Name = '设置切换提醒',
	Tooltip = '绑定的设置切换时通知你',
	Default = true,
	Darker = true
})

vape.GUIColor = vape.Categories.Main.Settings:CreateGUISlider({
	Name = '界面主题',
	Function = function(h, s, v)
		vape:UpdateGUI()
	end
})

vape.GUIBind = vape.Categories.Main.Settings:CreateBind({
	Name = '重新绑定界面',
	Default = {'RightShift'},
	NoRemove = true,
	Tooltip = '更改界面绑定按键'
})

--覆盖层

vape:Clean(task.spawn(function()
	local hue = 0
	repeat
		for _, component in vape.RainbowSliders do
			if component.Type == 'GUISlider' then
				component:SetValue(vape:Color(hue))
			else
				component:SetValue(hue)
			end
		end

		local delta = task.wait(1 / vape.RainbowUpdateSpeed.Value)
		hue = (hue + (delta * (0.2 * vape.RainbowSpeed.Value))) % 1
	until false
end))

local cursorConnection
vape:Clean(clickgui:GetPropertyChangedSignal('Visible'):Connect(function()
	vape:UpdateGUI()

	if clickgui.Visible and inputService.MouseEnabled then
		if cursorConnection then
			cursorConnection:Disconnect()
		end

		cursorConnection = runService.RenderStepped:Connect(function()
			local isVisible = clickgui.Visible
			for _, window in vape.Windows do
				isVisible = isVisible or window.Visible
			end

			if not isVisible then
				cursor.Visible = false
				cursorConnection:Disconnect()
				cursorConnection = nil
				return
			end

			cursor.Visible = not inputService.MouseIconEnabled
			if cursor.Visible then
				local mouseLocation = inputService:GetMouseLocation()
				cursor.Position = UDim2.fromOffset(mouseLocation.X - 31, mouseLocation.Y - 32)
			end
		end)
	end
end))

vape:Clean(function()
	if cursorConnection then
		cursorConnection:Disconnect()
	end
end)

vape:Clean(gui:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
	if vape.Scale.Enabled then
		scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.6)
	end
end))

vape:Clean(notifications.ChildRemoved:Connect(function()
	for index, notif in notifications:GetChildren() do
		if tween.Tween then
			tween:Tween(notif, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
				Position = UDim2.new(1, 0, 1, -(29 + (78 * index)))
			})
		end
	end
end))

vape:Clean(scale:GetPropertyChangedSignal('Scale'):Connect(function()
	scaledgui.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale)

	for _, obj in scaledgui:QueryDescendants('GuiObject >> [Visible = true]') do
		obj.Visible = false
		obj.Visible = true
	end
end))

vape:Clean(vape.GUIBind.Triggered:Connect(function()
	if vape.ThreadFix then
		setthreadidentity(8)
	end

	for _, window in self.Windows do
		window.Visible = false
	end

	for _, module in self.Modules do
		if module.Bind.Mobile then
			module.Bind.Mobile.Visible = clickgui.Visible
		end
	end

	clickgui.Visible = not clickgui.Visible
	vape:BlurCheck()
end))

vape:Clean(inputService.InputBegan:Connect(function(input)
	if vape.CurrentTooltip and input.KeyCode == Enum.KeyCode.LeftShift then
		vape.CurrentTooltip()
	end

	if not inputService:GetFocusedTextBox() and input.KeyCode ~= Enum.KeyCode.Unknown then
		table.insert(vape.HeldKeybinds, input.KeyCode.Name)
		if vape.Binding then return end

		for _, bind in vape.ActiveBinds do
			if checkKeybinds(vape.HeldKeybinds, bind.Keys, input.KeyCode.Name) then
				bind.Triggered:Fire(true)
			end
		end
	end
end))

vape:Clean(inputService.InputEnded:Connect(function(input)
	if vape.CurrentTooltip and input.KeyCode == Enum.KeyCode.LeftShift then
		vape.CurrentTooltip()
	end

	if not inputService:GetFocusedTextBox() and input.KeyCode ~= Enum.KeyCode.Unknown then
		if vape.Binding then
			if not vape.MultiKeybind.Enabled then
				vape.HeldKeybinds = {input.KeyCode.Name}
			end

			vape.Binding:SetBind(vape.HeldKeybinds, true)
			vape.Binding = nil
		else
			for _, bind in vape.ActiveBinds do
				if bind.Hold and checkKeybinds(vape.HeldKeybinds, bind.Keys, input.KeyCode.Name) then
					bind.Triggered:Fire(false)
				end
			end
		end
	end

	local index = table.find(vape.HeldKeybinds, input.KeyCode.Name)
	if index then
		table.remove(vape.HeldKeybinds, index)
	end
end))