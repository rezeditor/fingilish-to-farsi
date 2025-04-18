#Persistent
#UseHook
#InstallKeybdHook

SetBatchLines, -1
SendMode Input

toggle := true     ; فعال‌سازی پیش‌فرض، می‌تونی با Alt+F خاموش/روشن کنی
buffer := ""

!f:: ; Alt+F برای روشن/خاموش کردن
    toggle := !toggle
    TrayTip, Finglish IM, % toggle ? "فعال شد" : "غیرفعال شد", 1
return

; حذف یک کاراکتر از بافر و صفحه‌کلید
Backspace::
if (toggle && StrLen(buffer) > 0)
{
    StringTrimRight, buffer, buffer, 1
    SendInput {BS}
    return
}
SendInput {BS}
return

; گرفتن همه کلیدهای حرفی
~*a::handleChar("a")
~*b::handleChar("b")
~*c::handleChar("c")
~*d::handleChar("d")
~*e::handleChar("e")
~*f::handleChar("f")
~*g::handleChar("g")
~*h::handleChar("h")
~*i::handleChar("i")
~*j::handleChar("j")
~*k::handleChar("k")
~*l::handleChar("l")
~*m::handleChar("m")
~*n::handleChar("n")
~*o::handleChar("o")
~*p::handleChar("p")
~*q::handleChar("q")
~*r::handleChar("r")
~*s::handleChar("s")
~*t::handleChar("t")
~*u::handleChar("u")
~*v::handleChar("v")
~*w::handleChar("w")
~*x::handleChar("x")
~*y::handleChar("y")
~*z::handleChar("z")
~*Space::handleChar(" ")

return

; تابع پردازش
handleChar(char) {
    global toggle, buffer

    if (!toggle)
        return

    buffer .= char
    matched := ""

    ; بررسی ترکیب‌های 2 حرفی
    If (SubStr(buffer, -1) == "kh")
        matched := "{U+062E}"
    else if (SubStr(buffer, -1) == "sh")
        matched := "{U+0634}"
    else if (SubStr(buffer, -1) == "ch")
        matched := "{U+0686}"
    else if (SubStr(buffer, -1) == "gh")
        matched := "{U+063A}"
    else if (SubStr(buffer, -1) == "zh")
        matched := "{U+0698}"
    else if (SubStr(buffer, -1) == "ph")
        matched := "{U+0641}"
    else if (SubStr(buffer, -1) == "th")
        matched := "{U+062B}"

    if (matched != "") {
        SendInput {BS 2}
        SendInput %matched%
        StringTrimRight, buffer, buffer, 2
        return
    }

    ; تبدیل تکی‌ها
    last := SubStr(buffer, 0)

  trans := Object()
trans := Object()
trans["a"] := "{U+0627}"
trans["b"] := "{U+0628}"
trans["c"] := "{U+06A9}"
trans["d"] := "{U+062F}"
trans["e"] := ""
trans["f"] := "{U+0641}"
trans["g"] := "{U+06AF}"
trans["h"] := "{U+0647}"
trans["i"] := "{U+06CC}"
trans["j"] := "{U+062C}"
trans["k"] := "{U+06A9}"
trans["l"] := "{U+0644}"
trans["m"] := "{U+0645}"
trans["n"] := "{U+0646}"
trans["o"] := "{U+0648}"
trans["p"] := "{U+067E}"
trans["q"] := "{U+0642}"
trans["r"] := "{U+0631}"
trans["s"] := "{U+0633}"
trans["t"] := "{U+062A}"
trans["u"] := "{U+0648}"
trans["v"] := "{U+0648}"
trans["w"] := "{U+0648}"
trans["x"] := "{U+06A9}{U+0633}"
trans["y"] := "{U+06CC}"
trans["z"] := "{U+0632}"
trans[" "] := " "

    if (trans.HasKey(last)) {
        SendInput {BS}
        SendInput % trans[last]
        StringTrimRight, buffer, buffer, 1
    }
}
