-- textbox
tb = {}
function tb_init(voice, string)
	reading = true
	tb = {
		str = string,
		voice = voice,
		i = 1,
		cur = 0,
		char = 0,
		x = 8,
		y = 85,
		text_col = 9,
		outline_col = 4,
		dots_col = 1
	}
end

val = 0

function tb_update()
	val = tb.char
	if tb.char < #tb.str[tb.i] then
		tb.cur += 0.9
		if tb.cur > 0.9 then
			tb.char += 1
			tb.cur = 0
			if (ord(tb.str[tb.i], tb.char) != 32) sfx(tb.voice, 3)
		end
		if (btnp(𝘣𝘵𝘯_𝘰)) tb.char = #tb.str[tb.i]
	elseif btnp(𝘣𝘵𝘯_𝘰) then
		if #tb.str > tb.i then
			tb.i += 1
			tb.cur = 0
			tb.char = 0
		else
			reading = false
			t_increment = 1
		end
	end
end

local it = 0
function tb_draw()
	if reading then
		if it < 25 then it += 1 end
		t_increment = 0.02
		fillp(0x5f5f)
		rrectfill(mapx + 3, mapy + 83, outcubic(it, 0, 120, 25), outcubic(it, 0, 40, 25), 4, tb.dots_col)
		fillp(0x0000)
		rrect(mapx + 3, mapy + 83, outcubic(it, 0, 120, 25), outcubic(it, 0, 40, 25), 4, tb.outline_col)
		print(sub(tb.str[tb.i], 1, tb.char), mapx + tb.x - 1, mapy + tb.y + 2, tb.text_col)
	else
		it = 0
	end
end