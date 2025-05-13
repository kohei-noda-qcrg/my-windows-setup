#Requires AutoHotkey v2.0

*~LAlt::Send("{Blind}{vk07}")
*~RAlt::Send("{Blind}{vk07}")

~LAlt up::
{
    if (A_PriorKey = "LAlt") {
        Send("{vkF2sc070}{vkF3sc029}")
    }
}

~RAlt up::
{
    if (A_PriorKey = "RAlt") {
        Send("{vkF2sc070}")
    }
}
