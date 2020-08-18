%--Character superclass containing basic fields such as health and coordinates--%

unit
class Character
    export setCen, setHealth, getcX, getcY, getw, geth, getcol, erase, draw, setdead, dead, takedamage

    %------- Variables -------%
    var cX, cY, h, w, col, atk, health, dmgtaken : int
    var dead : boolean := false
    cX := 200
    cY := 200
    w := 24
    h := 35
    col := blue
    atk := 0
    health := 500
    dmgtaken := 50

    deferred proc draw % abstract method

    %------- Setter Methods -------%

    proc setCen (x, y : int)
	cX := x
	cY := y
    end setCen

    proc setHealth (h : int)
	health := h
    end setHealth

    proc setdead (x : boolean)
	dead := x
    end setdead

    proc takedamage
	health -= dmgtaken
    end takedamage

    %------- Getter Methods -------%

    fcn getHealth : int
	result health
    end getHealth

    fcn getcX : int
	result cX
    end getcX

    fcn getcY : int
	result cY
    end getcY

    fcn getw : int
	result w
    end getw

    fcn geth : int
	result h
    end geth

    fcn getcol : int
	result col
    end getcol

    proc erase
	var oldcol : int := getcol
	col := 0
	draw
	col := oldcol
    end erase
end Character



