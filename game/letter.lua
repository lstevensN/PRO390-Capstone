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
        
        if     self.type == "blank" and letter == 'a' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_a.png")
        elseif self.type == "blank" and letter == 'b' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_b.png")
        elseif self.type == "blank" and letter == 'c' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_c.png")
        elseif self.type == "blank" and letter == 'd' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_d.png")
        elseif self.type == "blank" and letter == 'e' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_e.png")
        elseif self.type == "blank" and letter == 'f' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_f.png")
        elseif self.type == "blank" and letter == 'g' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_g.png")
        elseif self.type == "blank" and letter == 'h' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_h.png")
        elseif self.type == "blank" and letter == 'i' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_i.png")
        elseif self.type == "blank" and letter == 'j' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_j.png")
        elseif self.type == "blank" and letter == 'k' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_k.png")
        elseif self.type == "blank" and letter == 'l' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_l.png")
        elseif self.type == "blank" and letter == 'm' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_m.png")
        elseif self.type == "blank" and letter == 'n' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_n.png")
        elseif self.type == "blank" and letter == 'o' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_o.png")
        elseif self.type == "blank" and letter == 'p' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_p.png")
        elseif self.type == "blank" and letter == 'q' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_q.png")
        elseif self.type == "blank" and letter == 'r' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_r.png")
        elseif self.type == "blank" and letter == 's' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_s.png")
        elseif self.type == "blank" and letter == 't' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_t.png")
        elseif self.type == "blank" and letter == 'u' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_u.png")
        elseif self.type == "blank" and letter == 'v' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_v.png")
        elseif self.type == "blank" and letter == 'w' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_w.png")
        elseif self.type == "blank" and letter == 'x' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_x.png")
        elseif self.type == "blank" and letter == 'y' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_y.png")
        elseif self.type == "blank" and letter == 'z' then image = love.graphics.newImage("game/assets/letters/blanks/blank_letter_z.png")
        end

        if     self.type == "iron" and letter == 'a' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_a.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier1.png")
        elseif self.type == "iron" and letter == 'b' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_b.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier3.png")
        elseif self.type == "iron" and letter == 'c' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_c.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier3.png")
        elseif self.type == "iron" and letter == 'd' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_d.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier2.png")
        elseif self.type == "iron" and letter == 'e' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_e.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier1.png")
        elseif self.type == "iron" and letter == 'f' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_f.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier4.png")
        elseif self.type == "iron" and letter == 'g' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_g.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier2.png")
        elseif self.type == "iron" and letter == 'h' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_h.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier3.png")
        elseif self.type == "iron" and letter == 'i' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_i.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier1.png")
        elseif self.type == "iron" and letter == 'j' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_j.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier5.png")
        elseif self.type == "iron" and letter == 'k' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_k.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier4.png")
        elseif self.type == "iron" and letter == 'l' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_l.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier2.png")
        elseif self.type == "iron" and letter == 'm' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_m.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier3.png")
        elseif self.type == "iron" and letter == 'n' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_n.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier2.png")
        elseif self.type == "iron" and letter == 'o' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_o.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier2.png")
        elseif self.type == "iron" and letter == 'p' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_p.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier3.png")
        elseif self.type == "iron" and letter == 'q' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_q.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier5.png")
        elseif self.type == "iron" and letter == 'r' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_r.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier1.png")
        elseif self.type == "iron" and letter == 's' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_s.png")
        preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier1.png")
        elseif self.type == "iron" and letter == 't' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_t.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier2.png")
        elseif self.type == "iron" and letter == 'u' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_u.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier3.png")
        elseif self.type == "iron" and letter == 'v' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_v.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier4.png")
        elseif self.type == "iron" and letter == 'w' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_w.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier4.png")
        elseif self.type == "iron" and letter == 'x' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_x.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier5.png")
        elseif self.type == "iron" and letter == 'y' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_y.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier4.png")
        elseif self.type == "iron" and letter == 'z' then
            image = love.graphics.newImage("game/assets/letters/irons/iron_letter_z.png")
            preview = love.graphics.newImage("game/assets/previews/iron/iron_preview_tier5.png")
        end

        if     self.type == "pierce" and letter == 'a' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_a.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier1.png")
        elseif self.type == "pierce" and letter == 'b' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_b.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier3.png")
        elseif self.type == "pierce" and letter == 'c' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_c.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier3.png")
        elseif self.type == "pierce" and letter == 'd' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_d.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier2.png")
        elseif self.type == "pierce" and letter == 'e' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_e.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier1.png")
        elseif self.type == "pierce" and letter == 'f' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_f.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier4.png")
        elseif self.type == "pierce" and letter == 'g' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_g.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier2.png")
        elseif self.type == "pierce" and letter == 'h' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_h.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier3.png")
        elseif self.type == "pierce" and letter == 'i' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_i.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier1.png")
        elseif self.type == "pierce" and letter == 'j' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_j.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier5.png")
        elseif self.type == "pierce" and letter == 'k' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_k.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier4.png")
        elseif self.type == "pierce" and letter == 'l' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_l.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier2.png")
        elseif self.type == "pierce" and letter == 'm' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_m.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier3.png")
        elseif self.type == "pierce" and letter == 'n' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_n.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier2.png")
        elseif self.type == "pierce" and letter == 'o' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_o.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier2.png")
        elseif self.type == "pierce" and letter == 'p' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_p.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier3.png")
        elseif self.type == "pierce" and letter == 'q' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_q.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier5.png")
        elseif self.type == "pierce" and letter == 'r' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_r.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier1.png")
        elseif self.type == "pierce" and letter == 's' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_s.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier1.png")
        elseif self.type == "pierce" and letter == 't' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_t.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier2.png")
        elseif self.type == "pierce" and letter == 'u' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_u.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier3.png")
        elseif self.type == "pierce" and letter == 'v' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_v.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier4.png")
        elseif self.type == "pierce" and letter == 'w' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_w.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier4.png")
        elseif self.type == "pierce" and letter == 'x' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_x.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier5.png")
        elseif self.type == "pierce" and letter == 'y' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_y.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier4.png")
        elseif self.type == "pierce" and letter == 'z' then
            image = love.graphics.newImage("game/assets/letters/pierces/pierce_letter_z.png")
            preview = love.graphics.newImage("game/assets/previews/pierce/pierce_preview_tier5.png")
        end

        if     self.type == "jade" and letter == 'a' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_a.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier1.png")
        elseif self.type == "jade" and letter == 'b' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_b.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier3.png")
        elseif self.type == "jade" and letter == 'c' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_c.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier3.png")
        elseif self.type == "jade" and letter == 'd' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_d.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier2.png")
        elseif self.type == "jade" and letter == 'e' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_e.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier1.png")
        elseif self.type == "jade" and letter == 'f' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_f.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier4.png")
        elseif self.type == "jade" and letter == 'g' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_g.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier2.png")
        elseif self.type == "jade" and letter == 'h' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_h.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier3.png")
        elseif self.type == "jade" and letter == 'i' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_i.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier1.png")
        elseif self.type == "jade" and letter == 'j' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_j.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier5.png")
        elseif self.type == "jade" and letter == 'k' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_k.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier4.png")
        elseif self.type == "jade" and letter == 'l' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_l.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier2.png")
        elseif self.type == "jade" and letter == 'm' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_m.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier3.png")
        elseif self.type == "jade" and letter == 'n' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_n.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier2.png")
        elseif self.type == "jade" and letter == 'o' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_o.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier2.png")
        elseif self.type == "jade" and letter == 'p' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_p.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier3.png")
        elseif self.type == "jade" and letter == 'q' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_q.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier5.png")
        elseif self.type == "jade" and letter == 'r' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_r.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier1.png")
        elseif self.type == "jade" and letter == 's' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_s.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier1.png")
        elseif self.type == "jade" and letter == 't' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_t.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier2.png")
        elseif self.type == "jade" and letter == 'u' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_u.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier3.png")
        elseif self.type == "jade" and letter == 'v' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_v.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier4.png")
        elseif self.type == "jade" and letter == 'w' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_w.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier4.png")
        elseif self.type == "jade" and letter == 'x' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_x.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier5.png")
        elseif self.type == "jade" and letter == 'y' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_y.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier4.png")
        elseif self.type == "jade" and letter == 'z' then
            image = love.graphics.newImage("game/assets/letters/jades/jade_letter_z.png")
            preview = love.graphics.newImage("game/assets/previews/jade/jade_preview_tier5.png")
        end

        if self.type == "glorb" then
            image = love.graphics.newImage("game/assets/letters/glorb.png")
            preview = love.graphics.newImage("game/assets/previews/glorb_preview.png")
        end

        return image, preview
    end

    self.image, self.preview = setImage()
    self.letter = letter
    self.value = setValue()
    self.jadeMultiplier = (self.type == "jade" and 5 / self.value or 0) + 1

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