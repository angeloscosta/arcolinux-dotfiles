import re

def replace_background(file_path, opacity=0.6):
    with open(file_path, 'r') as file:
        css_content = file.read()

    def replace_bg_with_alpha(match, type='background'):
        color = match.group(1)
        # return f'background-color: alpha({color}, {opacity});'
        return f'{type}: alpha({color}, {opacity});'

    # Regular expression to match background with a hex color code
    background_pattern = re.compile(r'background:\s*(#[0-9a-fA-F]{6});')
    new_bg_content = background_pattern.sub(replace_bg_with_alpha, css_content)
    with open(file_path, 'w') as file:
        file.write(new_bg_content)

def replace_background_color(file_path, opacity=0.6):
    with open(file_path, 'r') as file:
        css_content = file.read()

    def replace_bg_color_with_alpha(match, type='background-color'):
        color = match.group(1)
        # return f'background-color: alpha({color}, {opacity});'
        return f'{type}: alpha({color}, {opacity});'

    # Regular expression to match background-color with a hex color code
    background_color_pattern = re.compile(r'background-color:\s*(#[0-9a-fA-F]{6});')
    new_bg_color_content = background_color_pattern.sub(replace_bg_color_with_alpha, css_content)

    with open(file_path, 'w') as file:
        file.write(new_bg_color_content)

# Example usage
replace_background('.themes/Ayu-Glass/gtk-3.0/gtk.css', 0.6)
replace_background_color('.themes/Ayu-Glass/gtk-3.0/gtk.css', 0.6)

