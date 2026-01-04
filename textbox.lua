-- textbox
tb = {}
function tb_init(string)
	reading = true
	tb = {
		str = string,
		i = 1,
		cur = 0,
		char = 0
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
			if (ord(tb.str[tb.i], tb.char) != 32) sfx(15, 3)
		end
		if (btnp(BTN_O)) tb.char = #tb.str[tb.i]
	elseif btnp(BTN_O) then
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
		rrectfill(mapx + 3, mapy + 83, outcubic(it, 0, 120, 25), outcubic(it, 0, 40, 25), 4, 1)
		fillp(0x0000)
		rrect(mapx + 3, mapy + 83, outcubic(it, 0, 120, 25), outcubic(it, 0, 40, 25), 4, 4)
		print(sub(tb.str[tb.i], 1, tb.char), mapx + 7, mapy + 87, 9)
	else
		it = 0
	end
end