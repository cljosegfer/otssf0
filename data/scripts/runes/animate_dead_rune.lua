local rune = Spell("rune")

function rune.onCastSpell(player, variant)
	local position = variant:getPosition()
	local tile = Tile(position)
	if tile then
		local corpse = tile:getTopDownItem()
		if corpse then
			local itemType = corpse:getType()
			-- if itemType:isCorpse() and itemType:isMovable() then
			if itemType:isCorpse() then
				-- if #player:getSummons() < 2 and player:getSkull() ~= SKULL_BLACK then
				if player:getSkull() ~= SKULL_BLACK then
					local corpseName = corpse:getName()
					local prefix, monsterName = corpseName:match"^(%S+)%s+(.+)" -- remove preffix
					local summon = Game.createMonster(monsterName, position, true, false, player)
					if summon then
						corpse:remove()
						player:setSummon(summon)
						position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
						return true
					end
				else
					player:sendCancelMessage("You cannot control more creatures.")
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					return false
				end
			end
		end
	end

	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	return false
end

rune:id(83)
rune:group("support")
rune:name("animate dead rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_ANIMATE_DEAD_RUNE)
rune:runeId(3203)
rune:allowFarUse(true)
rune:charges(1)
rune:level(27)
rune:magicLevel(4)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:isBlocking(true) -- True = Solid / False = Creature
rune:register()
