%--Sunflower - Generates Sunlight as currency--%
unit
class Sunflower
    inherit Character in "Character"
    health := 300
    w := 20
    h := 20
    var sunflower := Pic.FileNew ("sunflowerfinal.bmp")

    body proc draw
	if health > 0 then
	    Pic.Draw (sunflower, cX - 46, cY - 46, picMerge)
	else
	    dead := true
	end if
    end draw

end Sunflower






