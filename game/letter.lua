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

local setBlank = function (l)
    if     l.type == "blank" and l.letter == 'a' then l.image = i_blank_a
    elseif l.type == "blank" and l.letter == 'b' then l.image = i_blank_b
    elseif l.type == "blank" and l.letter == 'c' then l.image = i_blank_c
    elseif l.type == "blank" and l.letter == 'd' then l.image = i_blank_d
    elseif l.type == "blank" and l.letter == 'e' then l.image = i_blank_e
    elseif l.type == "blank" and l.letter == 'f' then l.image = i_blank_f
    elseif l.type == "blank" and l.letter == 'g' then l.image = i_blank_g
    elseif l.type == "blank" and l.letter == 'h' then l.image = i_blank_h
    elseif l.type == "blank" and l.letter == 'i' then l.image = i_blank_i
    elseif l.type == "blank" and l.letter == 'j' then l.image = i_blank_j
    elseif l.type == "blank" and l.letter == 'k' then l.image = i_blank_k
    elseif l.type == "blank" and l.letter == 'l' then l.image = i_blank_l
    elseif l.type == "blank" and l.letter == 'm' then l.image = i_blank_m
    elseif l.type == "blank" and l.letter == 'n' then l.image = i_blank_n
    elseif l.type == "blank" and l.letter == 'o' then l.image = i_blank_o
    elseif l.type == "blank" and l.letter == 'p' then l.image = i_blank_p
    elseif l.type == "blank" and l.letter == 'q' then l.image = i_blank_q
    elseif l.type == "blank" and l.letter == 'r' then l.image = i_blank_r
    elseif l.type == "blank" and l.letter == 's' then l.image = i_blank_s
    elseif l.type == "blank" and l.letter == 't' then l.image = i_blank_t
    elseif l.type == "blank" and l.letter == 'u' then l.image = i_blank_u
    elseif l.type == "blank" and l.letter == 'v' then l.image = i_blank_v
    elseif l.type == "blank" and l.letter == 'w' then l.image = i_blank_w
    elseif l.type == "blank" and l.letter == 'x' then l.image = i_blank_x
    elseif l.type == "blank" and l.letter == 'y' then l.image = i_blank_y
    elseif l.type == "blank" and l.letter == 'z' then l.image = i_blank_z
    end
end

local setIron = function(l)
    if     l.type == "iron" and l.letter == 'a' then l.image = i_iron_a l.preview = i_iron_teir1
    elseif l.type == "iron" and l.letter == 'b' then l.image = i_iron_b l.preview = i_iron_teir3
    elseif l.type == "iron" and l.letter == 'c' then l.image = i_iron_c l.preview = i_iron_teir3
    elseif l.type == "iron" and l.letter == 'd' then l.image = i_iron_d l.preview = i_iron_teir2
    elseif l.type == "iron" and l.letter == 'e' then l.image = i_iron_e l.preview = i_iron_teir1
    elseif l.type == "iron" and l.letter == 'f' then l.image = i_iron_f l.preview = i_iron_teir4
    elseif l.type == "iron" and l.letter == 'g' then l.image = i_iron_g l.preview = i_iron_teir2
    elseif l.type == "iron" and l.letter == 'h' then l.image = i_iron_h l.preview = i_iron_teir3
    elseif l.type == "iron" and l.letter == 'i' then l.image = i_iron_i l.preview = i_iron_teir1
    elseif l.type == "iron" and l.letter == 'j' then l.image = i_iron_j l.preview = i_iron_teir5
    elseif l.type == "iron" and l.letter == 'k' then l.image = i_iron_k l.preview = i_iron_teir4
    elseif l.type == "iron" and l.letter == 'l' then l.image = i_iron_l l.preview = i_iron_teir2
    elseif l.type == "iron" and l.letter == 'm' then l.image = i_iron_m l.preview = i_iron_teir3
    elseif l.type == "iron" and l.letter == 'n' then l.image = i_iron_n l.preview = i_iron_teir2
    elseif l.type == "iron" and l.letter == 'o' then l.image = i_iron_o l.preview = i_iron_teir2
    elseif l.type == "iron" and l.letter == 'p' then l.image = i_iron_p l.preview = i_iron_teir3
    elseif l.type == "iron" and l.letter == 'q' then l.image = i_iron_q l.preview = i_iron_teir5
    elseif l.type == "iron" and l.letter == 'r' then l.image = i_iron_r l.preview = i_iron_teir1
    elseif l.type == "iron" and l.letter == 's' then l.image = i_iron_s l.preview = i_iron_teir1
    elseif l.type == "iron" and l.letter == 't' then l.image = i_iron_t l.preview = i_iron_teir5
    elseif l.type == "iron" and l.letter == 'u' then l.image = i_iron_u l.preview = i_iron_teir3
    elseif l.type == "iron" and l.letter == 'v' then l.image = i_iron_v l.preview = i_iron_teir4
    elseif l.type == "iron" and l.letter == 'w' then l.image = i_iron_w l.preview = i_iron_teir4
    elseif l.type == "iron" and l.letter == 'x' then l.image = i_iron_x l.preview = i_iron_teir5
    elseif l.type == "iron" and l.letter == 'y' then l.image = i_iron_y l.preview = i_iron_teir4
    elseif l.type == "iron" and l.letter == 'z' then l.image = i_iron_z l.preview = i_iron_teir5
    end
end

local setPierce = function (l)
    if     l.type == "pierce" and l.letter == 'a' then l.image = i_pierce_a l.preview = i_pierce_teir1
    elseif l.type == "pierce" and l.letter == 'b' then l.image = i_pierce_b l.preview = i_pierce_teir3
    elseif l.type == "pierce" and l.letter == 'c' then l.image = i_pierce_c l.preview = i_pierce_teir3
    elseif l.type == "pierce" and l.letter == 'd' then l.image = i_pierce_d l.preview = i_pierce_teir2
    elseif l.type == "pierce" and l.letter == 'e' then l.image = i_pierce_e l.preview = i_pierce_teir1
    elseif l.type == "pierce" and l.letter == 'f' then l.image = i_pierce_f l.preview = i_pierce_teir4
    elseif l.type == "pierce" and l.letter == 'g' then l.image = i_pierce_g l.preview = i_pierce_teir2
    elseif l.type == "pierce" and l.letter == 'h' then l.image = i_pierce_h l.preview = i_pierce_teir3
    elseif l.type == "pierce" and l.letter == 'i' then l.image = i_pierce_i l.preview = i_pierce_teir1
    elseif l.type == "pierce" and l.letter == 'j' then l.image = i_pierce_j l.preview = i_pierce_teir5
    elseif l.type == "pierce" and l.letter == 'k' then l.image = i_pierce_k l.preview = i_pierce_teir4
    elseif l.type == "pierce" and l.letter == 'l' then l.image = i_pierce_l l.preview = i_pierce_teir2
    elseif l.type == "pierce" and l.letter == 'm' then l.image = i_pierce_m l.preview = i_pierce_teir3
    elseif l.type == "pierce" and l.letter == 'n' then l.image = i_pierce_n l.preview = i_pierce_teir2
    elseif l.type == "pierce" and l.letter == 'o' then l.image = i_pierce_o l.preview = i_pierce_teir2
    elseif l.type == "pierce" and l.letter == 'p' then l.image = i_pierce_p l.preview = i_pierce_teir3
    elseif l.type == "pierce" and l.letter == 'q' then l.image = i_pierce_q l.preview = i_pierce_teir5
    elseif l.type == "pierce" and l.letter == 'r' then l.image = i_pierce_r l.preview = i_pierce_teir1
    elseif l.type == "pierce" and l.letter == 's' then l.image = i_pierce_s l.preview = i_pierce_teir1
    elseif l.type == "pierce" and l.letter == 't' then l.image = i_pierce_t l.preview = i_pierce_teir5
    elseif l.type == "pierce" and l.letter == 'u' then l.image = i_pierce_u l.preview = i_pierce_teir3
    elseif l.type == "pierce" and l.letter == 'v' then l.image = i_pierce_v l.preview = i_pierce_teir4
    elseif l.type == "pierce" and l.letter == 'w' then l.image = i_pierce_w l.preview = i_pierce_teir4
    elseif l.type == "pierce" and l.letter == 'x' then l.image = i_pierce_x l.preview = i_pierce_teir5
    elseif l.type == "pierce" and l.letter == 'y' then l.image = i_pierce_y l.preview = i_pierce_teir4
    elseif l.type == "pierce" and l.letter == 'z' then l.image = i_pierce_z l.preview = i_pierce_teir5
    end
end

local setJade = function (l)
    if     l.type == "jade" and l.letter == 'a' then l.image = i_jade_a l.preview = i_jade_teir1
    elseif l.type == "jade" and l.letter == 'b' then l.image = i_jade_b l.preview = i_jade_teir3
    elseif l.type == "jade" and l.letter == 'c' then l.image = i_jade_c l.preview = i_jade_teir3
    elseif l.type == "jade" and l.letter == 'd' then l.image = i_jade_d l.preview = i_jade_teir2
    elseif l.type == "jade" and l.letter == 'e' then l.image = i_jade_e l.preview = i_jade_teir1
    elseif l.type == "jade" and l.letter == 'f' then l.image = i_jade_f l.preview = i_jade_teir4
    elseif l.type == "jade" and l.letter == 'g' then l.image = i_jade_g l.preview = i_jade_teir2
    elseif l.type == "jade" and l.letter == 'h' then l.image = i_jade_h l.preview = i_jade_teir3
    elseif l.type == "jade" and l.letter == 'i' then l.image = i_jade_i l.preview = i_jade_teir1
    elseif l.type == "jade" and l.letter == 'j' then l.image = i_jade_j l.preview = i_jade_teir5
    elseif l.type == "jade" and l.letter == 'k' then l.image = i_jade_k l.preview = i_jade_teir4
    elseif l.type == "jade" and l.letter == 'l' then l.image = i_jade_l l.preview = i_jade_teir2
    elseif l.type == "jade" and l.letter == 'm' then l.image = i_jade_m l.preview = i_jade_teir3
    elseif l.type == "jade" and l.letter == 'n' then l.image = i_jade_n l.preview = i_jade_teir2
    elseif l.type == "jade" and l.letter == 'o' then l.image = i_jade_o l.preview = i_jade_teir2
    elseif l.type == "jade" and l.letter == 'p' then l.image = i_jade_p l.preview = i_jade_teir3
    elseif l.type == "jade" and l.letter == 'q' then l.image = i_jade_q l.preview = i_jade_teir5
    elseif l.type == "jade" and l.letter == 'r' then l.image = i_jade_r l.preview = i_jade_teir1
    elseif l.type == "jade" and l.letter == 's' then l.image = i_jade_s l.preview = i_jade_teir1
    elseif l.type == "jade" and l.letter == 't' then l.image = i_jade_t l.preview = i_jade_teir5
    elseif l.type == "jade" and l.letter == 'u' then l.image = i_jade_u l.preview = i_jade_teir3
    elseif l.type == "jade" and l.letter == 'v' then l.image = i_jade_v l.preview = i_jade_teir4
    elseif l.type == "jade" and l.letter == 'w' then l.image = i_jade_w l.preview = i_jade_teir4
    elseif l.type == "jade" and l.letter == 'x' then l.image = i_jade_x l.preview = i_jade_teir5
    elseif l.type == "jade" and l.letter == 'y' then l.image = i_jade_y l.preview = i_jade_teir4
    elseif l.type == "jade" and l.letter == 'z' then l.image = i_jade_z l.preview = i_jade_teir5
    end
end

local setGlorb = function (l) if l.type == "glorb" then l.image = i_glorb l.preview = i_glorb_preview end end

function Letter(l, xpos, ypos, type, trans)
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
    self.letter = l
    
    local firstClick = false
    
    local setValue = function ()
        if self.type == "pierce" then self.canPierce = true end
        if self.type == "glorb" then self.radius = 21 end
        
        if     self.letter == 'a' or self.letter == 'e' or self.letter == 'i' or self.letter == 'r' or self.letter == 's' then return (self.type == "iron" and 5 or 1)
        elseif self.letter == 'd' or self.letter == 'g' or self.letter == 'l' or self.letter == 'n' or self.letter == 'o' or self.letter == 't' then return (self.type == "iron" and 10 or 2)
        elseif self.letter == 'b' or self.letter == 'c' or self.letter == 'h' or self.letter == 'm' or self.letter == 'p' or self.letter == 'u' then return (self.type == "iron" and 15 or 3)
        elseif self.letter == 'f' or self.letter == 'k' or self.letter == 'v' or self.letter == 'w' or self.letter == 'y' then return (self.type == "iron" and 20 or 4)
        elseif self.letter == 'j' or self.letter == 'q' or self.letter == 'x' or self.letter == 'z' then return (self.type == "iron" and 25 or 5)
        elseif self.type == "glorb" then return "?"
        else return 0 end
    end
    
    self.image, self.preview = nil, nil
    
    if self.type == "blank" then setBlank(self)
    elseif self.type == "iron" then setIron(self)
    elseif self.type == "pierce" then setPierce(self)
    elseif self.type == "jade" then setJade(self)
    elseif self.type == "glorb" then setGlorb(self)
    end

    self.value = setValue()
    self.jadeMultiplier = (self.type == "jade" and self.value / 2 or 0) + 1
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