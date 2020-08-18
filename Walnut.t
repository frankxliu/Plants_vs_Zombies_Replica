%--Walnut - Protects as a shield against zombies--%
unit
class Walnut
    inherit Character in "Character.tu"
    health := 1000
    dmgtaken := 75

    var walnut := Pic.FileNew ("walnutfinal.bmp")

    body proc draw
    if health > 0 then
	Pic.Draw (walnut, cX - 46, cY - 46, picMerge)
    else
    dead := true
    end if
    end draw

end Walnut






