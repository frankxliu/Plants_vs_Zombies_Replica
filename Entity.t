%--Walnut Sunflower and Peashooter are exported in this to be used in the main run file--%
unit
class Entity
    import Walnut in "Walnut.t", Pea in "Pea.t", Sunflower in "Sunflower.t"
    export setCentre, draw, getplanttype, isdead, getentx, getenty, collisioncheck, resetbullethit, getbullethit, takedamage
    var Walnut1 : ^Walnut
    var Pea1 : ^Pea
    var Sunflower1 : ^Sunflower
    new Walnut1
    new Pea1
    new Sunflower1
    var planttype : int
    var entx : int
    var enty : int
    var isNewPea : boolean := true
    var bullethit : boolean := false
    
    %-------Procedures & Functions-------%
    proc collisioncheck (x, y : int)
	for i : 1 .. upper ( ^Pea1.arrOfBullets)
	    if ^ ( ^Pea1.arrOfBullets (i)).bulletx > x and ^ ( ^Pea1.arrOfBullets (i)).bullety > ((y div 100) * 100) and ^ ( ^Pea1.arrOfBullets (i)).bullety < ((y div 100) * 100 + 100) then
		^Pea1.setshoot (i, false)
		^Pea1.resetbullet (i)
		bullethit := true
	    end if
	end for
    end collisioncheck

    proc resetbullethit
	bullethit := false
    end resetbullethit

    proc setCentre (x, y, t : int)
	entx := x
	enty := y
	planttype := t
	^Walnut1.setCen (entx, enty)
	^Pea1.setCen (entx, enty)
	^Sunflower1.setCen (entx, enty)
    end setCentre

    proc takedamage
	^Pea1.takedamage
	^Walnut1.takedamage
	^Sunflower1.takedamage
    end takedamage

    fcn isdead : boolean
	if planttype = 1 then
	    result ^Walnut1.dead
	elsif planttype = 2 then
	    result ^Pea1.dead
	elsif planttype = 3 then
	    result ^Sunflower1.dead
	end if
    end isdead

    proc draw
	if planttype = 1 then
	    ^Walnut1.draw
	elsif planttype = 2 then
	    if isNewPea = true then
		^Pea1.setBulletPosition
		isNewPea := false
	    else
		^Pea1.draw
		^Pea1.moveBullet
		^Pea1.reloop
	    end if
	elsif planttype = 3 then
	    ^Sunflower1.draw
	end if
    end draw

    %-------Getter Methods-------%
    fcn getbullethit : boolean
	result bullethit
    end getbullethit

    fcn getentx : int
	result entx
    end getentx

    fcn getenty : int
	result enty
    end getenty

    fcn getplanttype : int
	result planttype
    end getplanttype

end Entity




