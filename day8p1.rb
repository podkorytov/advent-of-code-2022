#!/usr/bin/env ruby

forest = []

filename = 'inputs/input_day8.txt'
File.foreach(filename).each { |line|
    row = []
    line.split('').each { |c|
        if !c.strip.empty? 
            row.push(c.to_i)
        end
    }
    forest.push(row)
}

cols = forest[0].length
rows = forest.length
counter = 2 * cols + 2 * (rows - 2)

for c in 1..(cols-2) do
    for r in 1..(rows-2) do
        tree=forest[r][c]
        #check row left
        visible = 1
        for t in 0..(c-1) do
            if tree <= forest[r][t]
                visible = 0
                break
            end            
        end
        if visible > 0
            counter += 1
            next
        end 

        #check row right
        visible = 1
        for t in (c+1)..(cols-1) do
            if tree <= forest[r][t]
                visible = 0
                break
            end            
        end
        if visible > 0
            counter += 1
            next
        end 
        
        #check col top
        visible = 1
        for t in 0..(r-1) do
            if tree <= forest[t][c]
                visible = 0
                break
            end            
        end
        if visible > 0
            counter += 1
            next
        end 
        
        #check col bottom
        visible = 1
        for t in (r+1)..(rows-1) do
            if tree <= forest[t][c]
                visible = 0
                break
            end            
        end
        if visible > 0
            counter += 1
            next
        end 
    end
end

puts counter