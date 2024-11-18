Here's your `CONTRIBUTING_TO_WIKI.md` file:

---

# **Contributing to the Devlix Wiki**

Thank you for your interest in contributing to the Devlix Wiki! This document will guide you through setting up Docsify and working with the Markdown files that power the wiki.

---

## **Installing Docsify**  

Docsify is a simple tool to serve and build the Devlix Wiki. Follow the installation instructions for your distribution:  

### **Arch Linux**  
```bash
sudo pacman -S nodejs npm
sudo npm install -g docsify-cli
```

### **Debian/Ubuntu**  
```bash
sudo apt update && sudo apt install -y nodejs npm
sudo npm install -g docsify-cli
```

### **NixOS**  
Enable Node.js and npm in your configuration:  
1. Add the following to `/etc/nixos/configuration.nix`:  
   ```nix
   environment.systemPackages = with pkgs; [ nodejs npm ];
   ```
2. Rebuild your configuration:  
   ```bash
   sudo nixos-rebuild switch
   ```
3. Install Docsify:  
   ```bash
   npm install -g docsify-cli
   ```

### **Void Linux**  
```bash
sudo xbps-install -S nodejs npm
sudo npm install -g docsify-cli
```

### **Gentoo Linux**  
1. Install Node.js and npm:  
   ```bash
   sudo emerge --ask dev-lang/nodejs
   ```
2. Install Docsify:  
   ```bash
   npm install -g docsify-cli
   ```

---

## **Editing the Wiki**  

### **Cloning the Repository**  
First, clone Devlix WM repository to your local system:  
```bash
git clone https://github.com/Mohamed1242012/devlix.git
cd devlix/docs
```

### **Setting Up Docsify**  
To preview your changes locally:  
1. Navigate to the wiki directory:  
   ```bash
   cd devlix/docs
   ```
2. Start a local server:  
   ```bash
   docsify serve .
   ```
3. Open your browser and visit:  
   ```
   http://localhost:3000
   ```

### **Working with `_sidebar.md`**  
- The `_sidebar.md` file controls the sidebar menu of the wiki.  
- To add a new section:  
  1. Open `_sidebar.md` in your text editor.  
  2. Add a link to your new Markdown file. Example:  
     ```markdown
     - [Getting Started](getting_started.md)
     - [Installation](installation.md)
     - [Customization](customization.md)
     ```
- Ensure the file paths match the filenames in the repository.  

### **General Guidelines**  
- **DO NOT modify `index.html`.**  
- Focus only on Markdown (`.md`) files for content updates.  
- Test your changes locally before submitting a pull request.  

---

## **Submitting Changes**  

1. Commit your updates:  
   ```bash
   git add .
   git commit -m "Updated wiki: Added new section" # Here use `Updated wiki:` before commit message
   ```
2. Push your changes to your forked repository:  
   ```bash
   git push origin <branch-name>
   ```
3. Open a pull request to the main repository.  
