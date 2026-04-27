#function fish_greeting
#    set img (find ~/.config/fish/Pictures -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
#	# left Picture 
#    chafa "$img" --symbols ascii --size 10x5 > /tmp/img.txt
#	# right information
#    begin
#        echo "User: "(whoami)
#        # echo "Host: "(hostname)
#	# echo "Shell: "$SHELL
#        echo "Time: "(date "+%H:%M:%S")
#        echo "Uptime: "(uptime -p)
#        echo "Kernel: "(uname -r)
#        echo "OS: Arch Linux"
#    end > /tmp/info.txt
#	# together
#    paste /tmp/img.txt /tmp/info.txt
#end


function fish_greeting
    # ==================== 配置区域 ====================
    # 图片存放目录
    set -l img_dir "$HOME/.config/fish/Pictures"

    # 调整图片显示大小 (单位：终端单元格宽x高)
    # 上下结构建议把宽度设大（60-80），视觉上非常高清
    set -l img_w 15
    set -l img_h 15

    #    # 缩进量（让文字看起来更居中一些）
    set -l indent ""
    # =================================================

    # 1. 环境检查
    if not test -d "$img_dir"
        echo "提示: 请创建目录 $img_dir 并放入图片"
        return
    end

    # 随机获取一张图片
    set -l img (find "$img_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)

    if test -z "$img"
        echo "Welcome to Arch Linux!"
        return
    end

    # 2. 打印原生像素级高清图片
    # =========================================================================
    # 核心修改点：
    # 方案 A：Kitty 协议（目前最强画质，适用于 Kitty/WezTerm/Konsole）
    # 如果运行报错，请尝试方案 B。
    chafa "$img" --size {$img_w}x{$img_h} --format kitty

    # 方案 B：Sixel 协议（如果方案 A 报错或显示为乱码，尝试这行）
    # chafa "$img" --size {$img_w}x{$img_h} --format sixels
    # =========================================================================

    # 图片与文字之间的间隔
    #    echo ""

    # 3. 打印系统信息 (上图下文结构)
    # 这里优化了 Uptime 的 sed 正则，确保输出更干净
    echo -e $indent(set_color cyan --bold)"User:   " (set_color normal)(whoami)
    echo -e $indent(set_color blue --bold)"OS:     " (set_color normal)"Arch Linux"
    echo -e $indent(set_color yellow --bold)"Kernel: " (set_color normal)(uname -r)
    echo -e $indent(set_color red --bold)"Uptime: " (set_color normal)(uptime -p | sed 's/^up //')
    echo -e $indent(set_color magenta --bold)"Time:   " (set_color normal)(date "+%Y-%m-%d %H:%M:%S")

    # 重置颜色，确保终端后续输入正常
    set_color normal
    #    echo ""
end
