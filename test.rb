def execBlock(&block)
    block.call 'yes'
end

execBlock {|x| puts x}