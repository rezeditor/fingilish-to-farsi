def finglish_to_farsi_precise(text):
    combos = {
        'kh': 'خ',
        'sh': 'ش',
        'ch': 'چ',
        'gh': 'غ',
        'zh': 'ژ',
        'ph': 'ف',
        'th': 'ث',
    }

    singles = {
        'a': 'ا',
        'b': 'ب',
        'c': 'ک',  # فقط اگه ترکیب نبود
        'd': 'د',
        'e': 'e',
        'f': 'ف',
        'g': 'گ',
        'h': 'ه',
        'i': 'ی',
        'j': 'ج',
        'k': 'ک',
        'l': 'ل',
        'm': 'م',
        'n': 'ن',
        'o': 'و',
        'p': 'پ',
        'q': 'ق',
        'r': 'ر',
        's': 'س',
        't': 'ت',
        'u': 'و',
        'v': 'و',
        'w': 'و',
        'x': 'کس',
        'y': 'ی',
        'z': 'ز',
        ' ': ' ',
        '?': '؟',
    }

    i = 0
    result = ''
    text = text.lower()

    while i < len(text):
        matched = False
        # بررسی ترکیب‌ها اول
        for combo in combos:
            if text[i:i+len(combo)] == combo:
                result += combos[combo]
                i += len(combo)
                matched = True
                break
        if matched:
            continue
        # بررسی تک‌حرفی‌ها
        char = text[i]
        result += singles.get(char, char)
        i += 1

    return result


# تست:
input_text = "salam chera chon cheshm chador charkh"
output_text = finglish_to_farsi_precise(input_text)
print(output_text)
