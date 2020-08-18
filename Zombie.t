%--Zombie subclass - Main Antagonist of the game--%
unit
class Zombie
    inherit Character in "Character.tu"
    export move, setblock, attack, getplantblockx, getplantblocky, gethitplant, resethitplant, increasehealth, setbuckethead
    health := 200
    atk := 50
    var oriX : int := cX
    var oriY : int := cY
    var block : boolean := false
    var time1 : int := Time.Elapsed
    var time2 : int := Time.Elapsed
    var plantblockx : int
    var plantblocky : int
    var hitplant : boolean := false
    var buckethead : boolean := false
    dmgtaken := 50

    var zombie := Pic.FileNew ("zombiefinal.bmp")
    var bucketzombie := Pic.FileNew ("bucketzombie.bmp")

    
    %--Increasing The Health Of Buckethead Zombies--%
    proc setbuckethead (x : boolean)
	buckethead := x
	if x = true then
	    health := 250
	end if
    end setbuckethead

    %--Increases All Zombies Health As Waves Increase--%
    proc increasehealth (x : int)
	health += x * 50
    end increasehealth
    
    %--Resets Zombie Position To The Furthest X Value On The Main Grid--%
    proc reset
	cX := 999
	cY := oriY
    end reset

    
    %--Zombie Attack--%
    proc attack
	if block = true then
	    time2 := Time.Elapsed
	    if time2 - time1 > 2000 then
		Draw.FillOval (cX, cY + Rand.Int (-20, 20), 10, 10, yellow)
		hitplant := true
		time1 := time2
	    end if
	end if
    end attack

    body proc draw
	if health > 0 then
	    attack
	    if buckethead = false then
		Pic.Draw (zombie, cX - 15, cY - 45, picMerge)
	    elsif buckethead = true then
		Pic.Draw (bucketzombie, cX - 15, cY - 45, picMerge)
	    end if
	else
	    dead := true
	    reset
	end if
    end draw

    %--Zombie Stops Moving In Front Of Plant--%
    proc setblock (i : boolean, px, py : int)
	block := i
	plantblockx := px
	plantblocky := py
    end setblock

    %--Zombie Hit Test--%
    proc resethitplant
	hitplant := false
    end resethitplant

    proc move
	if block = false then
	    cX -= Rand.Int (0, 1)
	end if
    end move

    fcn getplantblockx : int
	result plantblockx
    end getplantblockx

    fcn getplantblocky : int
	result plantblocky
    end getplantblocky

    fcn gethitplant : boolean
	result hitplant
    end gethitplant
end Zombie



