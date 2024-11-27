--#region ASSETS
    -- Blanks
    local i_blank_a = love.graphics.newImage("game/assets/letters/blanks/blank_letter_a.png")
    local i_blank_b = love.graphics.newImage("game/assets/letters/blanks/blank_letter_b.png")
    local i_blank_c = love.graphics.newImage("game/assets/letters/blanks/blank_letter_c.png")
    local i_blank_d = love.graphics.newImage("game/assets/letters/blanks/blank_letter_d.png")
    local i_blank_e = love.graphics.newImage("game/assets/letters/blanks/blank_letter_e.png")
    local i_blank_f = love.graphics.newImage("game/assets/letters/blanks/blank_letter_f.png")
    local i_blank_g = love.graphics.newImage("game/assets/letters/blanks/blank_letter_g.png")
    local i_blank_h = love.graphics.newImage("game/assets/letters/blanks/blank_letter_h.png")
    local i_blank_i = love.graphics.newImage("game/assets/letters/blanks/blank_letter_i.png")
    local i_blank_j = love.graphics.newImage("game/assets/letters/blanks/blank_letter_j.png")
    local i_blank_k = love.graphics.newImage("game/assets/letters/blanks/blank_letter_k.png")
    local i_blank_l = love.graphics.newImage("game/assets/letters/blanks/blank_letter_l.png")
    local i_blank_m = love.graphics.newImage("game/assets/letters/blanks/blank_letter_m.png")
    local i_blank_n = love.graphics.newImage("game/assets/letters/blanks/blank_letter_n.png")
    local i_blank_o = love.graphics.newImage("game/assets/letters/blanks/blank_letter_o.png")
    local i_blank_p = love.graphics.newImage("game/assets/letters/blanks/blank_letter_p.png")
    local i_blank_q = love.graphics.newImage("game/assets/letters/blanks/blank_letter_q.png")
    local i_blank_r = love.graphics.newImage("game/assets/letters/blanks/blank_letter_r.png")
    local i_blank_s = love.graphics.newImage("game/assets/letters/blanks/blank_letter_s.png")
    local i_blank_t = love.graphics.newImage("game/assets/letters/blanks/blank_letter_t.png")
    local i_blank_u = love.graphics.newImage("game/assets/letters/blanks/blank_letter_u.png")
    local i_blank_v = love.graphics.newImage("game/assets/letters/blanks/blank_letter_v.png")
    local i_blank_w = love.graphics.newImage("game/assets/letters/blanks/blank_letter_w.png")
    local i_blank_x = love.graphics.newImage("game/assets/letters/blanks/blank_letter_x.png")
    local i_blank_y = love.graphics.newImage("game/assets/letters/blanks/blank_letter_y.png")
    local i_blank_z = love.graphics.newImage("game/assets/letters/blanks/blank_letter_z.png")


    -- Irons
    local i_iron_a = love.graphics.newImage("game/assets/letters/irons/iron_letter_a.png")
    local i_iron_b = love.graphics.newImage("game/assets/letters/irons/iron_letter_b.png")
    local i_iron_c = love.graphics.newImage("game/assets/letters/irons/iron_letter_c.png")
    local i_iron_d = love.graphics.newImage("game/assets/letters/irons/iron_letter_d.png")
    local i_iron_e = love.graphics.newImage("game/assets/letters/irons/iron_letter_e.png")
    local i_iron_f = love.graphics.newImage("game/assets/letters/irons/iron_letter_f.png")
    local i_iron_g = love.graphics.newImage("game/assets/letters/irons/iron_letter_g.png")
    local i_iron_h = love.graphics.newImage("game/assets/letters/irons/iron_letter_h.png")
    local i_iron_i = love.graphics.newImage("game/assets/letters/irons/iron_letter_i.png")
    local i_iron_j = love.graphics.newImage("game/assets/letters/irons/iron_letter_j.png")
    local i_iron_k = love.graphics.newImage("game/assets/letters/irons/iron_letter_k.png")
    local i_iron_l = love.graphics.newImage("game/assets/letters/irons/iron_letter_l.png")
    local i_iron_m = love.graphics.newImage("game/assets/letters/irons/iron_letter_m.png")
    local i_iron_n = love.graphics.newImage("game/assets/letters/irons/iron_letter_n.png")
    local i_iron_o = love.graphics.newImage("game/assets/letters/irons/iron_letter_o.png")
    local i_iron_p = love.graphics.newImage("game/assets/letters/irons/iron_letter_p.png")
    local i_iron_q = love.graphics.newImage("game/assets/letters/irons/iron_letter_q.png")
    local i_iron_r = love.graphics.newImage("game/assets/letters/irons/iron_letter_r.png")
    local i_iron_s = love.graphics.newImage("game/assets/letters/irons/iron_letter_s.png")
    local i_iron_t = love.graphics.newImage("game/assets/letters/irons/iron_letter_t.png")
    local i_iron_u = love.graphics.newImage("game/assets/letters/irons/iron_letter_u.png")
    local i_iron_v = love.graphics.newImage("game/assets/letters/irons/iron_letter_v.png")
    local i_iron_w = love.graphics.newImage("game/assets/letters/irons/iron_letter_w.png")
    local i_iron_x = love.graphics.newImage("game/assets/letters/irons/iron_letter_x.png")
    local i_iron_y = love.graphics.newImage("game/assets/letters/irons/iron_letter_y.png")
    local i_iron_z = love.graphics.newImage("game/assets/letters/irons/iron_letter_z.png")

    local i_iron_teir1 = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier1.png")
    local i_iron_teir2 = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier2.png")
    local i_iron_teir3 = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier3.png")
    local i_iron_teir4 = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier4.png")
    local i_iron_teir5 = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier5.png")


    -- Pierces
    local i_pierce_a = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_a.png")
    local i_pierce_b = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_b.png")
    local i_pierce_c = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_c.png")
    local i_pierce_d = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_d.png")
    local i_pierce_e = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_e.png")
    local i_pierce_f = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_f.png")
    local i_pierce_g = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_g.png")
    local i_pierce_h = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_h.png")
    local i_pierce_i = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_i.png")
    local i_pierce_j = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_j.png")
    local i_pierce_k = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_k.png")
    local i_pierce_l = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_l.png")
    local i_pierce_m = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_m.png")
    local i_pierce_n = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_n.png")
    local i_pierce_o = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_o.png")
    local i_pierce_p = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_p.png")
    local i_pierce_q = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_q.png")
    local i_pierce_r = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_r.png")
    local i_pierce_s = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_s.png")
    local i_pierce_t = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_t.png")
    local i_pierce_u = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_u.png")
    local i_pierce_v = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_v.png")
    local i_pierce_w = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_w.png")
    local i_pierce_x = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_x.png")
    local i_pierce_y = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_y.png")
    local i_pierce_z = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_z.png")

    local i_pierce_teir1 = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier1.png")
    local i_pierce_teir2 = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier2.png")
    local i_pierce_teir3 = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier3.png")
    local i_pierce_teir4 = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier4.png")
    local i_pierce_teir5 = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier5.png")


    -- Jades
    local i_jade_a = love.graphics.newImage("game/assets/letters/jades/jade_letter_a.png")
    local i_jade_b = love.graphics.newImage("game/assets/letters/jades/jade_letter_b.png")
    local i_jade_c = love.graphics.newImage("game/assets/letters/jades/jade_letter_c.png")
    local i_jade_d = love.graphics.newImage("game/assets/letters/jades/jade_letter_d.png")
    local i_jade_e = love.graphics.newImage("game/assets/letters/jades/jade_letter_e.png")
    local i_jade_f = love.graphics.newImage("game/assets/letters/jades/jade_letter_f.png")
    local i_jade_g = love.graphics.newImage("game/assets/letters/jades/jade_letter_g.png")
    local i_jade_h = love.graphics.newImage("game/assets/letters/jades/jade_letter_h.png")
    local i_jade_i = love.graphics.newImage("game/assets/letters/jades/jade_letter_i.png")
    local i_jade_j = love.graphics.newImage("game/assets/letters/jades/jade_letter_j.png")
    local i_jade_k = love.graphics.newImage("game/assets/letters/jades/jade_letter_k.png")
    local i_jade_l = love.graphics.newImage("game/assets/letters/jades/jade_letter_l.png")
    local i_jade_m = love.graphics.newImage("game/assets/letters/jades/jade_letter_m.png")
    local i_jade_n = love.graphics.newImage("game/assets/letters/jades/jade_letter_n.png")
    local i_jade_o = love.graphics.newImage("game/assets/letters/jades/jade_letter_o.png")
    local i_jade_p = love.graphics.newImage("game/assets/letters/jades/jade_letter_p.png")
    local i_jade_q = love.graphics.newImage("game/assets/letters/jades/jade_letter_q.png")
    local i_jade_r = love.graphics.newImage("game/assets/letters/jades/jade_letter_r.png")
    local i_jade_s = love.graphics.newImage("game/assets/letters/jades/jade_letter_s.png")
    local i_jade_t = love.graphics.newImage("game/assets/letters/jades/jade_letter_t.png")
    local i_jade_u = love.graphics.newImage("game/assets/letters/jades/jade_letter_u.png")
    local i_jade_v = love.graphics.newImage("game/assets/letters/jades/jade_letter_v.png")
    local i_jade_w = love.graphics.newImage("game/assets/letters/jades/jade_letter_w.png")
    local i_jade_x = love.graphics.newImage("game/assets/letters/jades/jade_letter_x.png")
    local i_jade_y = love.graphics.newImage("game/assets/letters/jades/jade_letter_y.png")
    local i_jade_z = love.graphics.newImage("game/assets/letters/jades/jade_letter_z.png")

    local i_jade_teir1 = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier1.png")
    local i_jade_teir2 = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier2.png")
    local i_jade_teir3 = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier3.png")
    local i_jade_teir4 = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier4.png")
    local i_jade_teir5 = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier5.png")


    -- Glorbs
    local i_glorb = love.graphics.newImage("game/assets/letters/glorb.png")
    local i_glorb_preview = love.graphics.newImage("game/assets/previews/glorb_preview.png")
--#endregion

function Letter(letter, xpos, ypos, type, trans)
    local self = {}
    
    self.x = xpos or 0
    self.y = ypos or 0
    self.xvel = 0
    self.yvel = 0
    self.type = type or "blank"
    self.canPierce = false
    self.radius = 24
    self.clicked = false
    self.hoveredOver = false
    self.transmuteMode = trans or false
    self.bubbleHeight = 0
    self.transmuting = false
    self.locked = false
    self.stored = false
    
    local firstClick = false
    
    local setValue = function ()
        if self.type == "pierce" then self.canPierce = true end
        if self.type == "glorb" then self.radius = 21 end
        
        if     letter == 'a' or letter == 'e' or letter == 'i' or letter == 'r' or letter == 's' then return (self.type == "iron" and 5 or 1)
        elseif letter == 'd' or letter == 'g' or letter == 'l' or letter == 'n' or letter == 'o' or letter == 't' then return (self.type == "iron" and 10 or 2)
        elseif letter == 'b' or letter == 'c' or letter == 'h' or letter == 'm' or letter == 'p' or letter == 'u' then return (self.type == "iron" and 15 or 3)
        elseif letter == 'f' or letter == 'k' or letter == 'v' or letter == 'w' or letter == 'y' then return (self.type == "iron" and 20 or 4)
        elseif letter == 'j' or letter == 'q' or letter == 'x' or letter == 'z' then return (self.type == "iron" and 25 or 5)
        elseif self.type == "glorb" then return "?"
        else return 0 end
    end
    
    local setImage = function ()
        local image, preview
        
        if     self.type == "blank" and letter == 'a' then image = i_blank_a
        elseif self.type == "blank" and letter == 'b' then image = i_blank_b
        elseif self.type == "blank" and letter == 'c' then image = i_blank_c
        elseif self.type == "blank" and letter == 'd' then image = i_blank_d
        elseif self.type == "blank" and letter == 'e' then image = i_blank_e
        elseif self.type == "blank" and letter == 'f' then image = i_blank_f
        elseif self.type == "blank" and letter == 'g' then image = i_blank_g
        elseif self.type == "blank" and letter == 'h' then image = i_blank_h
        elseif self.type == "blank" and letter == 'i' then image = i_blank_i
        elseif self.type == "blank" and letter == 'j' then image = i_blank_j
        elseif self.type == "blank" and letter == 'k' then image = i_blank_k
        elseif self.type == "blank" and letter == 'l' then image = i_blank_l
        elseif self.type == "blank" and letter == 'm' then image = i_blank_m
        elseif self.type == "blank" and letter == 'n' then image = i_blank_n
        elseif self.type == "blank" and letter == 'o' then image = i_blank_o
        elseif self.type == "blank" and letter == 'p' then image = i_blank_p
        elseif self.type == "blank" and letter == 'q' then image = i_blank_q
        elseif self.type == "blank" and letter == 'r' then image = i_blank_r
        elseif self.type == "blank" and letter == 's' then image = i_blank_s
        elseif self.type == "blank" and letter == 't' then image = i_blank_t
        elseif self.type == "blank" and letter == 'u' then image = i_blank_u
        elseif self.type == "blank" and letter == 'v' then image = i_blank_v
        elseif self.type == "blank" and letter == 'w' then image = i_blank_w
        elseif self.type == "blank" and letter == 'x' then image = i_blank_x
        elseif self.type == "blank" and letter == 'y' then image = i_blank_y
        elseif self.type == "blank" and letter == 'z' then image = i_blank_z
        end

        if     self.type == "iron" and letter == 'a' then image = i_iron_a preview = i_iron_teir1
        elseif self.type == "iron" and letter == 'b' then image = i_iron_b preview = i_iron_teir3
        elseif self.type == "iron" and letter == 'c' then image = i_iron_c preview = i_iron_teir3
        elseif self.type == "iron" and letter == 'd' then image = i_iron_d preview = i_iron_teir2
        elseif self.type == "iron" and letter == 'e' then image = i_iron_e preview = i_iron_teir1
        elseif self.type == "iron" and letter == 'f' then image = i_iron_f preview = i_iron_teir4
        elseif self.type == "iron" and letter == 'g' then image = i_iron_g preview = i_iron_teir2
        elseif self.type == "iron" and letter == 'h' then image = i_iron_h preview = i_iron_teir3
        elseif self.type == "iron" and letter == 'i' then image = i_iron_i preview = i_iron_teir1
        elseif self.type == "iron" and letter == 'j' then image = i_iron_j preview = i_iron_teir5
        elseif self.type == "iron" and letter == 'k' then image = i_iron_k preview = i_iron_teir4
        elseif self.type == "iron" and letter == 'l' then image = i_iron_l preview = i_iron_teir2
        elseif self.type == "iron" and letter == 'm' then image = i_iron_m preview = i_iron_teir3
        elseif self.type == "iron" and letter == 'n' then image = i_iron_n preview = i_iron_teir2
        elseif self.type == "iron" and letter == 'o' then image = i_iron_o preview = i_iron_teir2
        elseif self.type == "iron" and letter == 'p' then image = i_iron_p preview = i_iron_teir3
        elseif self.type == "iron" and letter == 'q' then image = i_iron_q preview = i_iron_teir5
        elseif self.type == "iron" and letter == 'r' then image = i_iron_r preview = i_iron_teir1
        elseif self.type == "iron" and letter == 's' then image = i_iron_s preview = i_iron_teir1
        elseif self.type == "iron" and letter == 't' then image = i_iron_t preview = i_iron_teir5
        elseif self.type == "iron" and letter == 'u' then image = i_iron_u preview = i_iron_teir3
        elseif self.type == "iron" and letter == 'v' then image = i_iron_v preview = i_iron_teir4
        elseif self.type == "iron" and letter == 'w' then image = i_iron_w preview = i_iron_teir4
        elseif self.type == "iron" and letter == 'x' then image = i_iron_x preview = i_iron_teir5
        elseif self.type == "iron" and letter == 'y' then image = i_iron_y preview = i_iron_teir4
        elseif self.type == "iron" and letter == 'z' then image = i_iron_z preview = i_iron_teir5
        end

        if     self.type == "pierce" and letter == 'a' then image = i_pierce_a preview = i_pierce_teir1
        elseif self.type == "pierce" and letter == 'b' then image = i_pierce_b preview = i_pierce_teir3
        elseif self.type == "pierce" and letter == 'c' then image = i_pierce_c preview = i_pierce_teir3
        elseif self.type == "pierce" and letter == 'd' then image = i_pierce_d preview = i_pierce_teir2
        elseif self.type == "pierce" and letter == 'e' then image = i_pierce_e preview = i_pierce_teir1
        elseif self.type == "pierce" and letter == 'f' then image = i_pierce_f preview = i_pierce_teir4
        elseif self.type == "pierce" and letter == 'g' then image = i_pierce_g preview = i_pierce_teir2
        elseif self.type == "pierce" and letter == 'h' then image = i_pierce_h preview = i_pierce_teir3
        elseif self.type == "pierce" and letter == 'i' then image = i_pierce_i preview = i_pierce_teir1
        elseif self.type == "pierce" and letter == 'j' then image = i_pierce_j preview = i_pierce_teir5
        elseif self.type == "pierce" and letter == 'k' then image = i_pierce_k preview = i_pierce_teir4
        elseif self.type == "pierce" and letter == 'l' then image = i_pierce_l preview = i_pierce_teir2
        elseif self.type == "pierce" and letter == 'm' then image = i_pierce_m preview = i_pierce_teir3
        elseif self.type == "pierce" and letter == 'n' then image = i_pierce_n preview = i_pierce_teir2
        elseif self.type == "pierce" and letter == 'o' then image = i_pierce_o preview = i_pierce_teir2
        elseif self.type == "pierce" and letter == 'p' then image = i_pierce_p preview = i_pierce_teir3
        elseif self.type == "pierce" and letter == 'q' then image = i_pierce_q preview = i_pierce_teir5
        elseif self.type == "pierce" and letter == 'r' then image = i_pierce_r preview = i_pierce_teir1
        elseif self.type == "pierce" and letter == 's' then image = i_pierce_s preview = i_pierce_teir1
        elseif self.type == "pierce" and letter == 't' then image = i_pierce_t preview = i_pierce_teir5
        elseif self.type == "pierce" and letter == 'u' then image = i_pierce_u preview = i_pierce_teir3
        elseif self.type == "pierce" and letter == 'v' then image = i_pierce_v preview = i_pierce_teir4
        elseif self.type == "pierce" and letter == 'w' then image = i_pierce_w preview = i_pierce_teir4
        elseif self.type == "pierce" and letter == 'x' then image = i_pierce_x preview = i_pierce_teir5
        elseif self.type == "pierce" and letter == 'y' then image = i_pierce_y preview = i_pierce_teir4
        elseif self.type == "pierce" and letter == 'z' then image = i_pierce_z preview = i_pierce_teir5
        end

        if     self.type == "jade" and letter == 'a' then image = i_jade_a preview = i_jade_teir1
        elseif self.type == "jade" and letter == 'b' then image = i_jade_b preview = i_jade_teir3
        elseif self.type == "jade" and letter == 'c' then image = i_jade_c preview = i_jade_teir3
        elseif self.type == "jade" and letter == 'd' then image = i_jade_d preview = i_jade_teir2
        elseif self.type == "jade" and letter == 'e' then image = i_jade_e preview = i_jade_teir1
        elseif self.type == "jade" and letter == 'f' then image = i_jade_f preview = i_jade_teir4
        elseif self.type == "jade" and letter == 'g' then image = i_jade_g preview = i_jade_teir2
        elseif self.type == "jade" and letter == 'h' then image = i_jade_h preview = i_jade_teir3
        elseif self.type == "jade" and letter == 'i' then image = i_jade_i preview = i_jade_teir1
        elseif self.type == "jade" and letter == 'j' then image = i_jade_j preview = i_jade_teir5
        elseif self.type == "jade" and letter == 'k' then image = i_jade_k preview = i_jade_teir4
        elseif self.type == "jade" and letter == 'l' then image = i_jade_l preview = i_jade_teir2
        elseif self.type == "jade" and letter == 'm' then image = i_jade_m preview = i_jade_teir3
        elseif self.type == "jade" and letter == 'n' then image = i_jade_n preview = i_jade_teir2
        elseif self.type == "jade" and letter == 'o' then image = i_jade_o preview = i_jade_teir2
        elseif self.type == "jade" and letter == 'p' then image = i_jade_p preview = i_jade_teir3
        elseif self.type == "jade" and letter == 'q' then image = i_jade_q preview = i_jade_teir5
        elseif self.type == "jade" and letter == 'r' then image = i_jade_r preview = i_jade_teir1
        elseif self.type == "jade" and letter == 's' then image = i_jade_s preview = i_jade_teir1
        elseif self.type == "jade" and letter == 't' then image = i_jade_t preview = i_jade_teir5
        elseif self.type == "jade" and letter == 'u' then image = i_jade_u preview = i_jade_teir3
        elseif self.type == "jade" and letter == 'v' then image = i_jade_v preview = i_jade_teir4
        elseif self.type == "jade" and letter == 'w' then image = i_jade_w preview = i_jade_teir4
        elseif self.type == "jade" and letter == 'x' then image = i_jade_x preview = i_jade_teir5
        elseif self.type == "jade" and letter == 'y' then image = i_jade_y preview = i_jade_teir4
        elseif self.type == "jade" and letter == 'z' then image = i_jade_z preview = i_jade_teir5
        end

        if self.type == "glorb" then image = i_glorb preview = i_glorb_preview end

        return image, preview
    end

    self.image, self.preview = setImage()
    self.letter = letter
    self.value = setValue()
    self.jadeMultiplier = (self.type == "jade" and self.value / 5 or 0) + 1
    self.pierceCount = (self.type == "pierce" and self.value or 1)

    self.update = function(dt)
        if self.transmuteMode == true then
            local mouseX, mouseY = love.mouse.getPosition()
            mouseX = (mouseX - XOffset) / ScaleFactor
            mouseY = mouseY / ScaleFactor

            if DistanceBetween(self.x, self.y, mouseX, mouseY) < self.radius then self.hoveredOver = true else self.hoveredOver = false end

            if love.mouse.isDown(1) then
                if firstClick == false then
                    firstClick = true
                    if DistanceBetween(self.x, self.y, mouseX, mouseY) < self.radius then self.clicked = true end
                elseif self.clicked == true then
                    self.x = mouseX
                    self.y = mouseY
                    self.xvel = 0
                    self.yvel = 0
                end
            else firstClick = false self.clicked = false end
        end
        
        self.x = self.x + self.xvel * dt
        self.y = self.y + self.yvel * dt
    end

    self.draw = function ()
        if self.transmuteMode == false then
            --[
            if self.canPierce == true then
                love.graphics.setColor(138/255, 43/255, 226/255)
                love.graphics.circle("line", self.x, self.y, self.radius + 1)
                love.graphics.setColor(1, 1, 1)
            elseif self.jadeMultiplier > 1 then
                love.graphics.setColor(25/255, 140/255, 39/255)
                love.graphics.circle("line", self.x, self.y, self.radius + 1)
                love.graphics.setColor(1, 1, 1)
            end
            --]]
        end

        if self.image ~= nil then love.graphics.draw(self.image, self.x, self.y, 0, 0.125, 0.125, 200, 200) end
    end

    return self
end