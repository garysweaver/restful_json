json.check "simple_barfoos-index: size=#{@barfoos.length}, ids=#{@barfoos.collect(&:favorite_food).join(',')}"