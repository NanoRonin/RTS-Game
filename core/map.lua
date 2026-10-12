local map = {}

function map:create(rows, columns, tileSize)
    local newMap = {
        settings = {
            rows = rows,
            columns = columns,
            tileSize = tileSize,
            startX = 0,
            startY = 0,
            lastClickedX = 0,
            lastClickedY = 0,
        },
        grid = {}
    }

    for x = 1, rows, 1 do
        newMap.grid[x] = {}

        for y = 1, columns, 1 do
            newMap.grid[x][y] = {
                type = 'r'
            }
        end
    end

    newMap.draw = map.draw
    newMap.update = map.update
    newMap.scroll = map.scroll
    newMap.rightClicked = map.rightClicked
    return newMap
end

function map:update(dt)
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.settings.startX = self.settings.startX + 250 * dt
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.settings.startX = self.settings.startX -  250 * dt
    end

    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.settings.startY = self.settings.startY + 250 * dt
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        self.settings.startY = self.settings.startY -  250 * dt
    end

    if love.mouse.isDown(2) then
        mouseX, mouseY = love.mouse.getPosition()

        if self.settings.lastClickedX > mouseX then
            self.settings.startX = self.settings.startX - (self.settings.lastClickedX - mouseX)/10
            self.settings.lastClickedX = self.settings.lastClickedX - (self.settings.lastClickedX - mouseX)/10
        end

        if self.settings.lastClickedX < mouseX then
            self.settings.startX = self.settings.startX - (self.settings.lastClickedX - mouseX)/10
            self.settings.lastClickedX = self.settings.lastClickedX - (self.settings.lastClickedX - mouseX)/10
        end

        if self.settings.lastClickedY > mouseY then
            self.settings.startY = self.settings.startY - (self.settings.lastClickedY - mouseY)/10
            self.settings.lastClickedY = self.settings.lastClickedY - (self.settings.lastClickedY - mouseY)/10
        end

        if self.settings.lastClickedY < mouseY then
            self.settings.startY = self.settings.startY - (self.settings.lastClickedY - mouseY)/10
            self.settings.lastClickedY = self.settings.lastClickedY - (self.settings.lastClickedY - mouseY)/10
        end
    end
    
end

function map:draw()
    for x = 1, self.settings.rows do
        for y = 1, self.settings.columns do
            local startX = self.settings.startX
            local startY = self.settings.startY
            local tileSize = self.settings.tileSize

            love.graphics.rectangle("fill", startX + (x - 1) * tileSize, startY + (y - 1) * tileSize, tileSize, tileSize)
        end
    end
end

function map:scroll(move)
    if move > 0 then
            self.settings.tileSize = self.settings.tileSize + 1
        elseif move < 0 then
            self.settings.tileSize = self.settings.tileSize - 1
        end

        local centerX = love.graphics.getWidth()/2
        local centerY = love.graphics.getHeight()/2

        local mouseX, mouseY = love.mouse.getPosition()

        if mouseX > centerX and move > 0 then
            self.settings.startX = self.settings.startX - 5
        elseif mouseX < centerX and move > 0 then
            self.settings.startX = self.settings.startX + 5
        end

        if mouseY > centerY and move > 0 then
            self.settings.startY = self.settings.startY - 5
        elseif mouseY < centerY and move > 0 then
            self.settings.startY = self.settings.startY + 5
    end
end

function map:rightClicked(x, y)
    self.settings.lastClickedX = x
    self.settings.lastClickedY = y
end

return map