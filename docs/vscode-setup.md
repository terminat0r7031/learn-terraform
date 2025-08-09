# 💻 VS Code Setup Guide for Terraform Development

This guide will help you set up Visual Studio Code with the HashiCorp Terraform extension for optimal Terraform development experience.

## 🎯 Overview

The HashiCorp Terraform extension for VS Code provides:
- **Syntax highlighting** for Terraform files
- **IntelliSense** and autocompletion
- **Terraform validation** and error detection
- **Format on save** capabilities
- **Resource documentation** on hover
- **Go to definition** and find references
- **Terraform plan** preview support

## 📋 Prerequisites

- Visual Studio Code installed
- Git for version control
- Internet connection for extension download

## 🚀 Installation Steps

### Step 1: Install VS Code

**macOS:**
```bash
# Using Homebrew
brew install --cask visual-studio-code

# Or download from https://code.visualstudio.com/
```

**Windows:**
```powershell
# Using Chocolatey
choco install vscode

# Or download from https://code.visualstudio.com/
```

**Ubuntu/Debian:**
```bash
# Using Snap
sudo snap install code --classic

# Or download .deb package from https://code.visualstudio.com/
```

### Step 2: Install HashiCorp Terraform Extension

**Method 1: VS Code Extensions Marketplace**
1. Open VS Code
2. Click on Extensions icon in the sidebar (Ctrl+Shift+X / Cmd+Shift+X)
3. Search for "HashiCorp Terraform"
4. Find the official extension by HashiCorp
5. Click "Install"

**Method 2: Command Line**
```bash
code --install-extension hashicorp.terraform
```

**Method 3: Quick Open**
1. Press Ctrl+P / Cmd+P
2. Type: `ext install hashicorp.terraform`
3. Press Enter

### Step 3: Verify Installation

1. Create a test file: `test.tf`
2. Add some Terraform code:
   ```hcl
   resource "aws_instance" "example" {
     ami           = "ami-12345678"
     instance_type = "t2.micro"
   }
   ```
3. Verify that you see:
   - Syntax highlighting (colors for keywords, strings, etc.)
   - IntelliSense suggestions when typing
   - "Terraform" in the bottom status bar

## ⚙️ Configuration

### Workspace Settings

The repository includes pre-configured VS Code settings in `.vscode/settings.json`:

```json
{
  "terraform.experimentalFeatures.validateOnSave": true,
  "terraform.experimentalFeatures.prefillRequiredFields": true,
  "terraform.format.enable": true,
  "editor.formatOnSave": true,
  "[terraform]": {
    "editor.defaultFormatter": "HashiCorp.terraform",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.formatDocument": true
    },
    "editor.tabSize": 2,
    "editor.insertSpaces": true
  }
}
```

### Key Features Enabled

- ✅ **Validate on Save**: Automatically validates Terraform files when saved
- ✅ **Format on Save**: Automatically formats code using `terraform fmt`
- ✅ **Prefill Required Fields**: Helps with autocomplete for required attributes
- ✅ **2-space Indentation**: Follows Terraform best practices
- ✅ **File Exclusions**: Hides `.terraform` directories from file explorer

### Extension Features

#### 1. Syntax Highlighting
- Resource types, data sources, and variables are color-coded
- Strings, numbers, and booleans have distinct colors
- Comments are visually differentiated

#### 2. IntelliSense
- Autocomplete for resource types and arguments
- Context-aware suggestions based on provider schema
- Hover documentation for resources and arguments

#### 3. Validation
- Real-time syntax error detection
- Terraform configuration validation
- Integration with Terraform Language Server

#### 4. Formatting
- Automatic code formatting with `terraform fmt`
- Consistent indentation and spacing
- Triggered on save or manually (Shift+Alt+F / Shift+Option+F)

#### 5. Navigation
- Go to definition (F12)
- Find all references (Shift+F12)
- Symbol search (Ctrl+Shift+O / Cmd+Shift+O)

## 🔧 Additional Setup

### Optional: Install Terraform CLI

While the VS Code extension provides most development features, you may want to install Terraform CLI for advanced operations:

**macOS:**
```bash
brew install terraform
```

**Windows:**
```powershell
choco install terraform
```

**Ubuntu/Debian:**
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

### Recommended Additional Extensions

The repository also recommends these complementary extensions:

- **AWS Toolkit**: For AWS resource management
- **GitLens**: Enhanced Git capabilities
- **YAML**: For YAML file support
- **JSON**: For JSON file support
- **GitHub Pull Requests**: For GitHub integration

## 🎯 Usage Tips

### 1. Create Terraform Files
- Use `.tf` extension for Terraform configuration files
- Use `.tfvars` for variable value files
- Use `.tfvars.example` for example variable files

### 2. Leverage IntelliSense
- Type `resource "` and see available resource types
- Use Ctrl+Space / Cmd+Space to trigger suggestions
- Hover over resources to see documentation

### 3. Format Code
- Save files to auto-format (if enabled)
- Use Shift+Alt+F / Shift+Option+F to format manually
- Format entire workspace with Command Palette > "Format Document"

### 4. Navigate Code
- Use F12 to go to resource definitions
- Use Shift+F12 to find all references
- Use Ctrl+T / Cmd+T to search symbols across workspace

### 5. Validate Configuration
- Save files to trigger validation
- Check Problems panel (Ctrl+Shift+M / Cmd+Shift+M) for errors
- Look for red squiggly lines indicating issues

## 🔍 Troubleshooting

### Extension Not Working
1. Check that the extension is installed and enabled
2. Look for "Terraform" in the bottom status bar
3. Restart VS Code if needed
4. Check VS Code output panel for error messages

### IntelliSense Not Working
1. Ensure file has `.tf` extension
2. Check that Terraform Language Server is running
3. Try reloading VS Code window (Ctrl+Shift+P > "Developer: Reload Window")

### Formatting Issues
1. Verify formatter is set to "HashiCorp.terraform"
2. Check that format on save is enabled
3. Manually format with Shift+Alt+F / Shift+Option+F

### Validation Errors
1. Check that Terraform syntax is correct
2. Ensure required providers are specified
3. Look at Problems panel for detailed error messages

## 📚 Resources

- [HashiCorp Terraform Extension Documentation](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
- [Terraform Language Server](https://github.com/hashicorp/terraform-ls)
- [VS Code Terraform Development](https://code.visualstudio.com/docs/languages/terraform)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

---

## ✅ Verification Checklist

After completing this setup, you should have:

- [ ] VS Code installed and running
- [ ] HashiCorp Terraform extension installed
- [ ] Syntax highlighting working for `.tf` files
- [ ] IntelliSense providing autocompletion
- [ ] Format on save enabled and working
- [ ] Validation errors showing in Problems panel
- [ ] Repository cloned and opened in VS Code
- [ ] All workspace settings applied

---

*This setup provides a professional Terraform development environment that will scale with your infrastructure needs. The extension will continue to provide value as you begin creating Terraform configurations.*
