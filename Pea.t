%--Peashooter Subclass - Shoots to defend against zombies--%
unit
class Pea
    inherit Character in "Character.tu"
    import Peabullet in "Peabullet.t"
    export setBulletPosition, addBulletToScreen, drawBullet, moveBullet, reloop,
	arrOfBullets, shoot, numBullets, setshoot, resetbullet

    %------- Set Inherit Variables -------%
    health := 300
    w := 20
    h := 20
    col := 2
    atk := 50
    dmgtaken := 75

    %------- Variables -------%
    var pea := Pic.FileNew ("peafinal.bmp")
    var numBullets : int := 7
    var numBulletsOnScreen : int := 0
    var arrOfBullets : array 1 .. 7 of ^Peabullet
    var shoot : array 1 .. 7 of boolean
    var time1, time2 : int := Time.Elapsed
    var originalX : int := cX
    var originalY : int := cY


    %------- Methods -------%
    body proc draw
	if health > 0 then
	    Pic.Draw (pea, cX - 46, cY - 46, picMerge)
	else
	    dead := true
	end if
    end draw

    proc setshoot (n : int, x : boolean) % sets a certain bullet in the array to shoot or not
	shoot (n) := x
    end setshoot

    proc addBulletToScreen  % creates a new bullet onto the screen
	if numBulletsOnScreen < numBullets then
	    numBulletsOnScreen += 1
	    shoot (numBulletsOnScreen) := true
	    if numBulletsOnScreen = numBullets then
		numBulletsOnScreen := 0
	    end if
	end if
    end addBulletToScreen

    proc setBulletPosition % sets original position of bullet
	for i : 1 .. numBullets
	    shoot (i) := false
	    new arrOfBullets (i)
	    ^ (arrOfBullets (i)).setBullet (cX, cY + 25)
	end for
    end setBulletPosition

    proc resetbullet (n : int) % resets bullet position to original peashooter plant
	^ (arrOfBullets (n)).setBullet (cX, cY + 25)
    end resetbullet

    proc drawBullet
	for i : 1 .. numBullets
	    if shoot (i) = true then
		^ (arrOfBullets (i)).drawBullet
	    end if
	end for
    end drawBullet

    proc moveBullet
	for i : 1 .. numBullets
	    if shoot (i) = true then
		^ (arrOfBullets (i)).increaseBulletx
		if ^ (arrOfBullets (i)).bulletx > maxx + 20 then
		    shoot (i) := false
		    ^ (arrOfBullets (i)).setBullet (cX, cY + 25)
		end if
	    end if
	end for
	drawBullet
    end moveBullet

    proc reloop % places a time interval between each peabullet shot, currently set to 2s 
	time2 := Time.Elapsed
	if time2 - time1 > 2000 then
	    addBulletToScreen
	    time1 := time2
	end if
    end reloop

end Pea







