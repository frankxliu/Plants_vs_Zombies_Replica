%Name Of Game: PLANTS VS ZOMBIES
%By: Brandon Tu, Frankie Liu, and Christopher Ko
/*Description: Quick! Your lawn has been invaded by a swarm of hungry
flesh eating zombies! All you have to protect yourself is a handful of 
seeds and some sunlight! Fight for your survival by planting to your 
hearts content. See how many waves you can defeat until you are eventually
overcome by the horde.

PS: The Class Hierarchy is in this folder as "classhierarchy.jpg"
*/


%--HUD--%
import Entity in "Entity.t", Zombie in "Zombie.t", GUI
View.Set ("graphics: 1000,600,offscreenonly, nobuttonbar")
colourback (98)


%-------Variables-------%
var statusfont : int := Font.New ("bahnschrift:20")
var costfont : int := Font.New ("bahnschrift:10")
var losefont : int := Font.New ("bahnschrift:60")
var mx, my, btnNum, btnUpDown : int
var n, s : int := 0
var build, shovel, cleartext : boolean := false
var entitygrid : array 1 .. 9, 1 .. 4 of ^Entity
var numBullets : int := 0
var ptype : int
var wave : int := 1
var losescreen : boolean := false

%---Lazers---%
%These are a one time protection against zombies that will clear the entire row
var lazer1, lazer2, lazer3, lazer4 : boolean := true

%---Waves---%
var wtime1 : int := Time.Elapsed
var wtime2 : int := Time.Elapsed
var timer : int := 60

%---Sunflower---%
%Generates Sunlight to fight
var sunlight : real := 200
var numSunflowerPlants : real := 0
var time1, time2 : int := Time.Elapsed
var sunlightfont : int := Font.New ("bahnschrift:15")
var sunlightsubfont : int := Font.New ("bahnschrift:13")

%---Zombie---%
%Tries to invade lawn
var zombiegrid : flexible array 1 .. 0 of ^Zombie
var visible : flexible array 1 .. 0 of boolean
var ztime1 : int := Time.Elapsed
var ztime2 : int := Time.Elapsed
var spawn : int := 0
var settime : int := 3000
var numzombies : int

%---Icons---%
var smallpea := Pic.FileNew ("smallpeafinal.bmp")
var smallwalnut := Pic.FileNew ("smallwalnutfinal.bmp")
var smallsunflower := Pic.FileNew ("smallsunflowerfinal.bmp")
var garden := Pic.FileNew ("title.jpg")
var shovelpic := Pic.FileNew ("shovel.jpg")
var backpic := Pic.FileNew ("back.jpg")
var grass := Pic.FileNew ("grassfinal.jpg")
var instructionspic := Pic.FileNew ("instructions.jpg")


%-------Procedures & Functions-------%
proc wavetime
    wtime2 := Time.Elapsed
    if wtime2 - wtime1 >= 1000 then
	if timer > 0 then
	    timer -= 1
	end if
	wtime1 := wtime2
    end if
    Draw.FillBox (880, 535, 990, 553, 98)
end wavetime

%--Draws Blue Boxes Around Plant Select Icons--%
proc drawBox (x, y : int)
    Draw.ThickLine (x, y, x + 70, y, 5, 55)
    Draw.ThickLine (x + 70, y, x + 70, y + 70, 5, 55)
    Draw.ThickLine (x + 70, y + 70, x, y + 70, 5, 55)
    Draw.ThickLine (x, y + 70, x, y, 5, 55)
end drawBox

proc updatecannon
    if lazer1 = false then
	Draw.FillBox (40, 130, 50, 180, 112)
    end if
    if lazer2 = false then
	Draw.FillBox (40, 230, 50, 280, 112)
    end if
    if lazer3 = false then
	Draw.FillBox (40, 330, 50, 380, 112)
    end if
    if lazer4 = false then
	Draw.FillBox (40, 430, 50, 480, 112)
    end if
end updatecannon

proc drawlazercannon
    % Lazer1
    Draw.FillBox (0, 130, 50, 180, 22)
    Draw.FillBox (0, 125, 20, 185, 34)
    Draw.FillBox (0, 125, 6, 185, 107)

    % Lazer2
    Draw.FillBox (0, 230, 50, 280, 22)
    Draw.FillBox (0, 225, 20, 285, 34)
    Draw.FillBox (0, 225, 6, 285, 107)

    % Lazer3
    Draw.FillBox (0, 330, 50, 380, 22)
    Draw.FillBox (0, 325, 20, 385, 34)
    Draw.FillBox (0, 325, 6, 385, 107)

    % Lazer4
    Draw.FillBox (0, 430, 50, 480, 22)
    Draw.FillBox (0, 425, 20, 485, 34)
    Draw.FillBox (0, 425, 6, 485, 107)
    updatecannon
end drawlazercannon

proc drawStage
    for i : 1 .. 9
	for j : 1 .. 4
	    Pic.Draw (grass, i * 100, j * 100, picMerge)
	end for
    end for
    % Vertical Lines
    Draw.ThickLine (100, 100, 100, 500, 3, black)
    Draw.ThickLine (200, 100, 200, 500, 3, black)
    Draw.ThickLine (300, 100, 300, 500, 3, black)
    Draw.ThickLine (400, 100, 400, 500, 3, black)
    Draw.ThickLine (500, 100, 500, 500, 3, black)
    Draw.ThickLine (600, 100, 600, 500, 3, black)
    Draw.ThickLine (700, 100, 700, 500, 3, black)
    Draw.ThickLine (800, 100, 800, 500, 3, black)
    Draw.ThickLine (900, 100, 900, 500, 3, black)
    Draw.ThickLine (999, 100, 999, 500, 3, black)
    % Horizontal Lines
    Draw.ThickLine (100, 100, 1000, 100, 3, black)
    Draw.ThickLine (100, 200, 1000, 200, 3, black)
    Draw.ThickLine (100, 300, 1000, 300, 3, black)
    Draw.ThickLine (100, 400, 1000, 400, 3, black)
    Draw.ThickLine (100, 500, 1000, 500, 3, black)

    % Select Icons
    drawBox (415, 515)
    Pic.Draw (smallsunflower, 425, 533, picMerge)
    Draw.Text ("70", 450, 523, costfont, black)
    Draw.FillOval (440, 526, 5, 5, yellow)
    drawBox (515, 515)
    Pic.Draw (smallwalnut, 525, 533, picMerge)
    Draw.Text ("90", 550, 523, costfont, black)
    Draw.FillOval (540, 526, 5, 5, yellow)
    drawBox (615, 515)
    Pic.Draw (smallpea, 625, 532, picMerge)
    Draw.Text ("100", 650, 523, costfont, black)
    Draw.FillOval (640, 526, 5, 5, yellow)


    Pic.Draw (shovelpic, 720, 515, picMerge)
    Pic.Draw (backpic, 810, 515, picMerge)


    Draw.Text ("Wave: " + intstr (wave), 890, 550, sunlightfont, black)
    Draw.Text ("Starting in: " + intstr (timer), 890, 535, sunlightsubfont, black)

    drawlazercannon
end drawStage

proc drawSunText
    Draw.FillOval (130, 560, 15, 15, yellow)
    Draw.Text (realstr (sunlight, 1) + " Sunlight", 160, 555, sunlightfont, black)
    Draw.Text (realstr (numSunflowerPlants * 2, 1) + " Snlt/s", 180, 535, sunlightsubfont, black)
end drawSunText


proc drawPlantBox (x, y : int)
    if x > 0 and x < 10 and y > 0 and y < 5 then
	Draw.ThickLine ((x * 100) + 5, (y * 100) + 5, (x * 100) + 95, (y * 100) + 5, 3, 48)
	Draw.ThickLine ((x * 100) + 95, (y * 100) + 5, (x * 100) + 95, (y * 100) + 95, 3, 48)
	Draw.ThickLine ((x * 100) + 95, (y * 100) + 95, (x * 100) + 5, (y * 100) + 95, 3, 48)
	Draw.ThickLine ((x * 100) + 5, (y * 100) + 95, (x * 100) + 5, (y * 100) + 5, 3, 48)
	View.Update
	Draw.ThickLine ((x * 100) + 5, (y * 100) + 5, (x * 100) + 95, (y * 100) + 5, 3, 0)
	Draw.ThickLine ((x * 100) + 95, (y * 100) + 5, (x * 100) + 95, (y * 100) + 95, 3, 0)
	Draw.ThickLine ((x * 100) + 95, (y * 100) + 95, (x * 100) + 5, (y * 100) + 95, 3, 0)
	Draw.ThickLine ((x * 100) + 5, (y * 100) + 95, (x * 100) + 5, (y * 100) + 5, 3, 0)
    end if
end drawPlantBox

proc drawShovelBox (x, y : int)
    if x > 0 and x < 10 and y > 0 and y < 5 then
	Draw.ThickLine ((x * 100) + 5, (y * 100) + 5, (x * 100) + 95, (y * 100) + 5, 3, 12)
	Draw.ThickLine ((x * 100) + 95, (y * 100) + 5, (x * 100) + 95, (y * 100) + 95, 3, 12)
	Draw.ThickLine ((x * 100) + 95, (y * 100) + 95, (x * 100) + 5, (y * 100) + 95, 3, 12)
	Draw.ThickLine ((x * 100) + 5, (y * 100) + 95, (x * 100) + 5, (y * 100) + 5, 3, 12)
	View.Update
	Draw.ThickLine ((x * 100) + 5, (y * 100) + 5, (x * 100) + 95, (y * 100) + 5, 3, 0)
	Draw.ThickLine ((x * 100) + 95, (y * 100) + 5, (x * 100) + 95, (y * 100) + 95, 3, 0)
	Draw.ThickLine ((x * 100) + 95, (y * 100) + 95, (x * 100) + 5, (y * 100) + 95, 3, 0)
	Draw.ThickLine ((x * 100) + 5, (y * 100) + 95, (x * 100) + 5, (y * 100) + 5, 3, 0)
    end if
end drawShovelBox

%--Grid Setup--%
var taken : array 1 .. 9, 1 .. 4 of boolean
var plantgrid : array 1 .. 9, 1 .. 4 of int

for i : 1 .. 9
    for j : 1 .. 4
	plantgrid (i, j) := 0
	taken (i, j) := false
    end for
end for

%--Checks If  X and Y are inside the grid range--%
fcn spaceTaken (x : int, y : int) : boolean
    if x > 0 and x < 10 then
	if y > 0 and y < 5 then
	    result taken (x, y)
	end if
    end if
    result true
end spaceTaken

%--Grid Highlighting--%
proc highlight
    if mx > 100 and my > 100 and my < 500 then
	n := (mx div 100)
	s := (my div 100)
	if spaceTaken (n, s) = false then
	    Draw.FillBox ((n * 100) + 4, (s * 100) + 4, (n * 100) + 96, (s * 100) + 96, 40)
	end if

    end if
    n := 0
    s := 0
end highlight

%--Main Update Procedure--%
proc update
    if build = false and shovel = false then
	View.Update
	cls
    end if
end update

%--Selecting Plant--%
proc select
    cleartext := true
    if Mouse.ButtonMoved ("down") and mx > 415 and mx < 485 and my > 515 and my < 585 then
	Mouse.ButtonWait ("up", mx, my, btnNum, btnUpDown)
	ptype := 3
	build := true
    elsif Mouse.ButtonMoved ("down") and mx > 515 and mx < 585 and my > 515 and my < 585 then
	Mouse.ButtonWait ("up", mx, my, btnNum, btnUpDown)
	ptype := 1
	build := true
    elsif Mouse.ButtonMoved ("down") and mx > 615 and mx < 685 and my > 515 and my < 585 then
	Mouse.ButtonWait ("up", mx, my, btnNum, btnUpDown)
	ptype := 2
	build := true
    elsif Mouse.ButtonMoved ("down") and mx >= 720 and mx <= 785 and my >= 515 and my <= 580 then
	Mouse.ButtonWait ("up", mx, my, btnNum, btnUpDown)
	build := false
	shovel := true
    elsif Mouse.ButtonMoved ("down") and mx >= 810 and mx <= 860 and my >= 515 and my <= 565 then
	Mouse.ButtonWait ("up", mx, my, btnNum, btnUpDown)
	build := false
	shovel := false
    end if
end select

%--Checks If Zombie Is On Plant Square--%
fcn zombieonplant (n, s : int) : boolean
    var ifzompresent : boolean := false
    for i : 1 .. upper (zombiegrid)
	if (( ^ (zombiegrid (i)).getcX) div 100) = n and (( ^ (zombiegrid (i)).getcY) div 100) = s then
	    ifzompresent := true
	end if
    end for
    result ifzompresent
end zombieonplant

%--Checks If Player Has Enough Sunlight--%
fcn cost : boolean
    if ptype = 3 and not zombieonplant (n, s) then
	if sunlight > 70 then
	    sunlight -= 70
	    result true
	else
	    result false
	end if
    elsif ptype = 1 and not zombieonplant (n, s) then
	if sunlight > 90 then
	    sunlight -= 90
	    result true
	else
	    result false
	end if
    elsif ptype = 2 and not zombieonplant (n, s) then
	if sunlight > 100 then
	    sunlight -= 100
	    result true
	else
	    result false
	end if
    end if
    result false
end cost

%--Main Planting Procedure--%
proc plant
    n := (mx div 100)
    s := (my div 100)
    drawPlantBox (n, s)
    select
    if Mouse.ButtonMoved ("down") then
	Mouse.ButtonWait ("up", mx, my, btnNum, btnUpDown)
	if mx > 100 and my > 100 and my < 500 and build = true then
	    if spaceTaken (n, s) = false then
		if cost = true then
		    if zombieonplant (n, s) = false then
			plantgrid (n, s) := ptype
			new entitygrid (n, s)
			^ (entitygrid (n, s)).setCentre ((n * 100) + 50, (s * 100) + 50, ptype)
			taken (n, s) := true
			build := false
			if ptype = 3 then
			    numSunflowerPlants += 1
			end if
		    else
			Draw.FillBox (100, 20, 800, 80, 98)
			Draw.Text ("A zombie is there!", 440, 50, statusfont, black)
		    end if
		elsif cost = false and zombieonplant (n, s) = false then
		    Draw.FillBox (100, 20, 800, 80, 98)
		    Draw.Text ("Not enough sunlight!", 440, 50, statusfont, black)
		elsif cost = true and zombieonplant (n, s) = true then
		    Draw.FillBox (100, 20, 800, 80, 98)
		    Draw.Text ("A zombie is there!", 440, 50, statusfont, black)
		end if
	    else
		Draw.FillBox (100, 20, 800, 80, 98)
		Draw.Text ("A plant is already there!", 440, 50, statusfont, black)
	    end if
	end if
    end if
end plant

%--Checks Peabullet Collisions--%
proc checkbullethit
    for n : 1 .. 9
	for s : 1 .. 4
	    if plantgrid (n, s) = 2 then
		for k : 1 .. upper (zombiegrid)
		    if visible (k) = true then
			^ (entitygrid (n, s)).collisioncheck ( ^ (zombiegrid (k)).getcX, ^ (zombiegrid (k)).getcY)
			if ^ (entitygrid (n, s)).getbullethit = true then
			    ^ (zombiegrid (k)).takedamage
			    ^ (entitygrid (n, s)).resetbullethit
			end if
		    end if
		end for
	    end if
	end for
    end for
end checkbullethit

%--Redraw All Plants--%
proc redrawplant
    for n : 1 .. 9
	for s : 1 .. 4
	    if taken (n, s) = true then
		if ^ (entitygrid (n, s)).isdead = false then
		    ^ (entitygrid (n, s)).draw
		else
		    plantgrid (n, s) := 0
		    taken (n, s) := false
		end if
	    end if
	end for
    end for
end redrawplant

%--Gain Sunlight--%
proc gainsunlight
    time2 := Time.Elapsed
    if time2 - time1 > 1000 then
	sunlight += numSunflowerPlants * 2
	time1 := time2
    end if
    Draw.FillBox (160, 550, 285, 570, 98)
    drawSunText
end gainsunlight

%--Set Zombies X and Y--%
proc setZombies
    numzombies := wave * (Rand.Int (4, 6))
    new zombiegrid, numzombies
    new visible, numzombies
    for i : 1 .. numzombies
	new zombiegrid (i)
	visible (i) := false
	^ (zombiegrid (i)).setdead (false)
	^ (zombiegrid (i)).setCen (900, Rand.Int (1, 4) * 100 + 50)
	if Rand.Int(1,5) = 1 then
	^ (zombiegrid(i)).setbuckethead(true)
	end if
    end for
end setZombies

%--Make Zombies Visible To Grid--%
proc spawnZombies
    if timer = 0 then
	ztime2 := Time.Elapsed
	if ztime2 - ztime1 > settime then
	    if spawn < upper (zombiegrid) then
		spawn += 1
	    end if
	    visible (spawn) := true
	    ztime1 := ztime2
	end if
    end if
end spawnZombies

%--Checks If Zombie Infront of Plant--%
proc checkblock (z : ^Zombie)
    var zX : int := ^z.getcX div 100
    var zY : int := ^z.getcY div 100
    if plantgrid (zX, zY) ~= 0 then
	^z.setblock (true, zX, zY)
    else
	^z.setblock (false, zX, zY)
    end if
end checkblock

%--Checks if Zombie Hits Plant--%
proc checkattacked
    for i : 1 .. upper (zombiegrid)
	if ^ (zombiegrid (i)).gethitplant = true then
	    ^ (entitygrid ( ^ (zombiegrid (i)).getplantblockx, ^ (zombiegrid (i)).getplantblocky)).takedamage
	    ^ (zombiegrid (i)).resethitplant
	end if
    end for
end checkattacked

%--Draw The Zombies--%
proc drawZombies
    for i : 1 .. upper (zombiegrid)
	if visible (i) = true then
	    ^ (zombiegrid (i)).draw
	end if
    end for
end drawZombies

%--Moves The Zombies--%
proc moveZombies
    for i : 1 .. upper (zombiegrid)
	if visible (i) = true then
	    checkblock (zombiegrid (i))
	    ^ (zombiegrid (i)).move
	    ^ (zombiegrid (i)).draw
	end if
    end for
end moveZombies

%--Checks If Any Plants Or Zombies Are Dead--%
proc checkdead
    for i : 1 .. 9
	for j : 1 .. 4
	    if plantgrid (i, j) ~= 0 then
		if ^ (entitygrid (i, j)).isdead = true then
		    if plantgrid (i, j) = 3 then
			numSunflowerPlants -= 1
		    end if
		    taken (i, j) := false
		    plantgrid (i, j) := 0
		end if
	    end if
	end for
    end for
    for k : 1 .. upper (zombiegrid)
	if ^ (zombiegrid (k)).dead = true then
	    visible (k) := false
	end if
    end for
end checkdead

%--Use Shovel to Remove Plants--%
proc useshovel
    n := (mx div 100)
    s := (my div 100)
    drawShovelBox (n, s)
    select
    if Mouse.ButtonMoved ("down") then
	Mouse.ButtonWait ("up", mx, my, btnNum, btnUpDown)
	if mx > 100 and my > 100 and my < 500 then
	    if taken (n, s) = true then
		if plantgrid (n, s) = 3 then
		    numSunflowerPlants -= 1
		end if

		plantgrid (n, s) := 0
		taken (n, s) := false
		shovel := false
	    elsif taken (n, s) = false then
		Draw.FillBox (100, 20, 700, 80, 98)
		Draw.Text ("There's nothing there!", 435, 50, statusfont, black)
	    end if
	end if
    end if
end useshovel

%--Check If Wave Ends--%
fcn checkendwave : boolean
    var numzombiedead : int := 0
    for i : 1 .. upper (zombiegrid)
	if ^ (zombiegrid (i)).dead = true then
	    numzombiedead += 1
	end if
    end for
    if numzombiedead = numzombies then
	result true
    else
	result false
    end if
end checkendwave

%--Giant Lazer Animation--%
proc lazer (x : int)
    var lazerx : int := 0
    var lazery : int

    if x = 1 and lazer1 = true then
	lazery := 145
	lazer1 := false
    elsif x = 2 and lazer2 = true then
	lazery := 245
	lazer2 := false
    elsif x = 3 and lazer3 = true then
	lazery := 345
	lazer3 := false
    elsif x = 4 and lazer4 = true then
	lazery := 445
	lazer4 := false
    else
	losescreen := true
    end if

    loop
	if losescreen = false then
	    drawStage
	    Draw.FillBox (0, lazery, lazerx, lazery + 20, blue)
	    Draw.FillBox (0, lazery + 5, lazerx, lazery + 15, 54)
	    drawSunText
	    drawZombies
	    redrawplant
	    drawlazercannon
	    lazerx += 16
	    View.Update
	    if lazerx > maxx + 100 then
		cls
		exit
	    end if
	else
	    exit
	end if
    end loop

    if losescreen = false then
	for i : 1 .. upper (zombiegrid)
	    if visible (i) = true and ( ^ (zombiegrid (i)).getcY) div 100 = x then
		visible (i) := false
		^ (zombiegrid (i)).setdead (true)
	    end if
	end for
    end if
end lazer

%--Checks If Zombie Reaches End of Grid--%
proc checkzombiepast
    for i : 1 .. upper (zombiegrid)
	if visible (i) = true and ^ (zombiegrid (i)).getcX <= 100 then
	    lazer (( ^ (zombiegrid (i)).getcY) div 100)
	end if
    end for
end checkzombiepast

%--Increase Zombies' Health According to Waves--%
proc increasezomhealth
    for i : 1 .. upper (zombiegrid)
	^ (zombiegrid (i)).increasehealth (wave)
    end for
end increasezomhealth

%--Compilation of Repetitive Procs in Main Loop--%
proc longproc
    wavetime
    drawStage
    checkdead
    checkbullethit
    checkattacked
    checkzombiepast
    spawnZombies
    moveZombies
    gainsunlight
end longproc

%--Graphical User Interface--%

%--Start Button GUI in Menu--%
var starty : int := 0
procedure start %exits loops when buttons are pressed
    GUI.Quit
    starty := 1
end start


%--Back Button In Menu--%
procedure back
    GUI.Quit
    starty := 0
end back

%--Draws Instructions--%
procedure instructions
    Draw.FillBox (0, 0, maxx, maxy, 80)
    Pic.Draw (instructionspic, -80, 70, picMerge)
    var startgame : int := GUI.CreateButton (230, 30, 0, "Play", start)
    var backgame : int := GUI.CreateButton (450, 30, 0, "Back", back)
    View.Update
    Input.Flush
    loop
	exit when GUI.ProcessEvent
    end loop
end instructions



%------MAIN RUN CODE-----%
loop
    loop
	starty := 0
	GUI.ResetQuit
	View.Update
	Draw.FillBox (0, 0, maxx, maxy, 80)
	Pic.Draw (garden, -80, 70, picMerge)
	var startbutton : int := GUI.CreateButton (230, 30, 0, "Play", start)
	var instructionsbutton : int := GUI.CreateButton (650, 30, 0, "Instructions", instructions)
	View.Update
	loop
	    exit when GUI.ProcessEvent
	end loop
	if starty = 1 then
	    starty := 0
	    exit
	end if
    end loop
    loop
	setZombies
	drawStage
	loop
	    mousewhere (mx, my, btnNum)
	    longproc
	    highlight
	    select
	    if build = true or shovel = true then
		loop
		    mousewhere (mx, my, btnNum)
		    longproc
		    redrawplant
		    if build = true then
			plant
		    elsif shovel = true then
			useshovel
		    end if
		    update
		    exit
		end loop
	    end if
	    redrawplant
	    update
	    if checkendwave = true then
		wave += 1
		timer := 10
		spawn := 0
		if settime > 750 then
		    settime -= 230
		else
		    settime -= 150
		end if
		setZombies
		increasezomhealth
	    end if
	    if losescreen = true then
		exit
	    end if
	end loop
	if losescreen = true then
	    exit
	end if
	if losescreen = true then
	    exit
	end if
    end loop
    cls
    Draw.Text ("YOU LOSE", 300, 300, losefont, black)
    if wave > 1 then
	Draw.Text ("YOU LASTED " + intstr (wave) + " WAVES", 340, 200, statusfont, black)
    else
	Draw.Text ("YOU LASTED 1 WAVE :(", 350, 200, statusfont, black)
    end if

    View.Update
    delay (5000)

    for i : 1 .. 9
	for j : 1 .. 4
	    plantgrid (i, j) := 0
	    taken (i, j) := false
	end for
    end for

    for i : 1 .. upper (zombiegrid)
	new zombiegrid, upper (zombiegrid) - 1
	new visible, upper (visible) - 1
    end for

    wave := 1
    spawn := 0
    sunlight := 200
    n := 0
    s := 0
    numBullets := 0
    lazer1 := true
    lazer2 := true
    lazer3 := true
    lazer4 := true
    timer := 60
    
    GUI.ResetQuit

    losescreen := false
end loop





















