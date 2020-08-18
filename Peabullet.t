%--Pea Bullet - Draws The Peas That The Peashooter Shoots--%
unit
class Peabullet
    export setBullet, drawBullet, increaseBulletx, bulletx, bullety, eraseBullet

    %-------Variables-------%
    var bulletx, bullety : int
    var bullet := Pic.FileNew ("greenball.bmp")

    %-------Procedures & Functions-------%
    proc setBullet (x, y : int)
	bulletx := x
	bullety := y
    end setBullet

    proc increaseBulletx
	bulletx += 2
    end increaseBulletx

    proc drawBullet
	Pic.Draw (bullet, bulletx - 45, bullety - 45, picMerge)
    end drawBullet

    proc eraseBullet
	Draw.FillOval (bulletx, bullety, 15, 15, white)
    end eraseBullet
end Peabullet







