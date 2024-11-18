# Devlix WM Full Guide  

> This page covers all Devlix key bindings, their usage, and explains key concepts like layouts, tags, and window behaviors in detail to help you maximize your efficiency with Devlix.  

---

## What Are Tags

Tags in Devlix function like "workspaces" or "virtual desktops" in other systems. Instead of assigning windows to fixed desktops, Devlix lets you assign windows to tags, which are flexible and dynamic.  

- **How Tags Work**:  
  Each window is assigned to one or more tags (labeled `1` to `9` by default). You can view, switch, and manipulate tags to control which windows are visible at any time. For example:  
  - If you're working on a coding project, you might assign your editor to tag `1` and your browser to tag `2`.  
  - You can easily switch between these tags to focus on specific tasks.  

- **Why Use Tags?**  
  Tags let you group related windows without cluttering your workspace. This grouping is highly customizable and allows for a clean workflow.  


## Window Behavior  

In Devlix, new windows are placed based on the current layout and the position of the focused window:  

- **Tiled Layout**:  
  - If a window in the stack is focused, the new window is added below it in the stack.  
  - If the master area is focused, the new window is added to the stack.  

- **Floating Layout**:  
  - New windows are freely movable and do not affect the tiled structure.  

- **Monocle Layout**:  
  - New windows are maximized and added to the focus cycle without disrupting the current full-screen view.  

This behavior ensures intuitive placement of new windows and smooth workflow transitions.  


## Mod Keys  

In Devlix, the **Mod Key** serves as a modifier key that, when pressed in combination with other keys, triggers various commands and actions. By default, Devlix uses two Mod Keys, which you can customize according to your preferences:

- **`Mod1`**: **Alt Key** (default)
  - This is the standard **Alt** key on most keyboards, which is used as the default modifier for many commands in Devlix. For example, pressing `Alt + t` switches the layout to tiled mode.

- **`Mod4`**: **Super Key** (Windows key)
  - The **Super** key is the key with the **Windows logo** on it, typically found between the `Alt` and `Fn` keys. In Devlix, this key can also serve as a modifier for various actions, like launching applications or switching between layouts.

### Why Use Mod Keys?  

The use of Mod Keys helps avoid key conflicts and allows you to perform multiple actions with combinations of keys without interfering with your typing. For instance, the **Mod1 (Alt)** and **Mod4 (Super)** keys ensure that your standard typing functions are unaffected while still allowing you to quickly access window management features and layouts in Devlix.

By using Mod Keys, you can perform tasks quickly without having to remember complex commands or access menus.


## Layouts and Keybindings  

### What Are Layouts?  
Layouts control how windows are arranged on the screen. Devlix supports three primary layouts:  

1. **Tile Layout**:  
   - Divides the screen into a master area (left) and a stack area (right).  
   - The master area is for the most important window (e.g., your editor), while the stack area is for less critical windows.  
   - The size of the master area can be adjusted.  

2. **Floating Layout**:  
   - Allows you to move and resize windows freely.  
   - Ideal for tasks where specific window placement is important, such as designing or video editing.  

3. **Monocle Layout**:  
   - Maximizes each window to fill the entire screen.  
   - Only one window is visible at a time, but you can quickly cycle through windows.  

### Layout Keybindings  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + t`                       | Use tile layout (default Devlix layout)   |
| `Alt + f`                       | Use floating layout                    |
| `Alt + m`                       | Use monocle layout                     |
| `Alt + Space`                   | Toggle the last layouts                |
| `Alt + Shift + Space`           | Toggle focused window layout (tiled or floating) |


## Working with Tags  

### Assigning and Viewing Tags  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + 1` to `Alt + 9`          | View windows assigned to a specific tag |
| `Alt + Shift + (1-9)`           | Assign the focused window to a tag     |
| `Alt + Shift + 0`               | Assign all tags to the focused window  |
| `Alt + 0`                       | View all windows, regardless of tags   |

- **View Tags**: When you press `Alt + [number]`, only the windows assigned to that tag are visible.  
- **Assign Tags**: If you want a window to appear in a specific tag, focus on it and press `Alt + Shift + [number]`.  
- **View All Tags**: Use `Alt + 0` to see all windows across all tags simultaneously.  

### Why Assign Multiple Tags?  
A single window can belong to multiple tags. For instance, if a browser window is relevant to both tag `1` (coding) and tag `3` (research), you can assign it to both.  

### Switching Between Tags  
You can switch between tags using `Alt + [number]` or toggle specific tags by clicking them in the tag bar.  


## Opening and Closing Windows  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + Shift + Return`          | Open terminal (`alacritty`)            |
| `Alt + Shift + c`               | Close the focused window               |


## Switching Window Focus  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + j`                       | Focus the next window in the stack     |
| `Alt + k`                       | Focus the previous window in the stack |
| `Alt + Tab`                     | Toggle through active tags             |


## Tiled Layout Shortcuts  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + i`                       | Increase the number of windows in the master area |
| `Alt + d`                       | Decrease the number of windows in the master area |
| `Alt + h`                       | Decrease the master area size          |
| `Alt + l`                       | Increase the master area size          |
| `Alt + Shift + j`               | Move the focused window down in the stack |
| `Alt + Shift + k`               | Move the focused window up in the stack |
| `Alt + Return`                  | Swap the focused window with the master |


## Quitting DWM  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + Shift + q`               | Quit DWM                               |


## Toggle the Top Bar  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + b`                       | Show/hide the top bar                  |


## Mousing Around  

| Mouse Action                                      | Usage                                    |
|--------------------------------------------------|------------------------------------------|
| Left Click on Layout Symbol                      | Toggle last layouts                      |
| Right Click on Layout Symbol                     | Set layout to monocle                    |
| Middle Click on Window Title                     | Zoom in                                  |
| Middle Click on Status Text                      | Open terminal (`alacritty`)              |
| `Alt` + Left Click on Client Window              | Move window                              |
| `Alt` + Middle Click on Client Window            | Toggle floating mode for this window     |
| `Alt` + Right Click on Client Window             | Resize window                            |
| Left Click on Tag Bar                            | View windows in the selected tag         |
| Right Click on Tag Bar                           | Toggle view of the selected tag          |
| `Alt` + Left Click on Tag Bar                    | Move the focused window to another tag   |
| `Alt` + Right Click on Tag Bar                   | Toggle the current tag for the focused window |


## Screens  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + comma`                   | Focus the previous monitor             |
| `Alt + period`                  | Focus the next monitor                 |
| `Alt + Shift + comma`           | Send the focused window to the previous monitor |
| `Alt + Shift + period`          | Send the focused window to the next monitor |


## Other Keybindings  

| Keybind                         | Usage                                  |
|---------------------------------|----------------------------------------|
| `Alt + s`                       | Take a screenshot (`scrot`)            |
| `Alt + p`                       | Open the application menu (`dmenu`)    |
| `Audio Mute Key`                | Mute audio                             |
| `Audio Lower Volume Key`        | Lower audio volume                     |
| `Audio Raise Volume Key`        | Raise audio volume                     |
| `Super (Windows) + Space`       | Change keyboard layout                 |
| `Brightness Up Key`             | Increase screen brightness             |
| `Brightness Down Key`           | Decrease screen brightness             |
| `Power Key` / `Pause`           | Show the power menu                    |
| `Alt + minus`                   | Decrease gaps between windows          |
| `Alt + equal`                   | Increase gaps between windows          |
| `Alt + Shift + equal`           | Reset gaps to default                  |


> With these keybindings and features, you can navigate and customize Devlix WM to suit your workflow, making it an efficient and powerful environment for your tasks.
