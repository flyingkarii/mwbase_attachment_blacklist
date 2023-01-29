# Modern Warfare Base: Attachment Group Blacklist
Blacklist attachment groups (perks, ammo, magazines, etc) from guns.

## Features
- Ban specific attachment groups (such as perks, ammo, magazines, etc)
- Remove special attachment groups with wildcards (such as *_mag to remove the ammo attachment group for every special gun who thinks they're cool)
- Get a list of all attachment group names with concommand "mw_attgroups" (should only work in console but i might be dumb, untested)
- Works with every custom weapon addon as long as you add their custom stuff (where wildcards are useful, a feature in this addon)

### Eventually:
- ban specific attachment groups for certain guns, darkrp jobs, and usergroups.

## Installation 
* Download the addon as a zip<br>
* Extract to any folder<br>
* Drag folder to your server's addons (NOT SINGLEPLAYER FRIENDLY) folder and you're done. Only runs on server start so does not impact performance whatsoever when in-game.<br>
* Edit through mwbase_attgroup_ban/lua/autorun/attachment_blacklist.lua<br>
* Use list found through "mw_attgroups" in your player console. Anything super long ending with \_mag or something should use wildcards table.

## Issues 
Please use the issues tab for any issues you encounter with the base addon. There is no support for edited versions, and I won't help you with syntax errors. This addon requires very beginner syntax understanding for tables and table keys.
