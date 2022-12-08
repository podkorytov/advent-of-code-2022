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
max = 0
for c in 1..(cols-2) do
    for r in 1..(rows-2) do
        tree=forest[r][c]
        
        #check row left
        distance_l = 1
        t = c - 1
        while t > 0
            if tree <= forest[r][t]
                break
            end  
            distance_l += 1
            t -= 1
        end

        #check row right
        distance_r = 1
        t = c + 1
        while t < (cols-1)
            if tree <= forest[r][t]
                break
            end  
            distance_r += 1
            t += 1
        end
        
        #check col top
        distance_t = 1
        t = r - 1
        while t > 0
            if tree <= forest[t][c]
                break
            end  
            distance_t += 1
            t -= 1
        end
        
        #check col bottom
        distance_b = 1
        t = r + 1
        while t < (rows-1)
            if tree <= forest[t][c]
                break
            end  
            distance_b += 1
            t += 1
        end

        distance = distance_l * distance_r * distance_t * distance_b
        if distance > max 
            max = distance
        end
    end
end

puts max