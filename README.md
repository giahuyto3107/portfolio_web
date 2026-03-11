# Portfolio Website - Flutter Web

A high-performance, single-page portfolio website built with Flutter Web, designed to showcase mobile development expertise.

## Features

- 🎨 **Dark-mode-first design** - Modern, sleek aesthetic
- 📱 **Mobile-responsive** - Looks great on all devices
- ⚡ **High performance** - Static site, no backend required
- 🎯 **Mobile-first UX** - Demonstrates mobile development expertise

## Sections

1. **Hero Section** - Punchy headline with CTA buttons
2. **Featured Project (NutriPal)** - Deep dive with QR code for beta testing
3. **Project Gallery** - Responsive grid of project cards
4. **Technical Toolkit** - Skills organized by category
5. **About & Education** - Personal and academic background
6. **Contact Footer** - Social links and credits

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK

### Installation

```bash
# Install dependencies
flutter pub get

# Run in development
flutter run -d chrome

# Build for production
flutter build web --release
```

### Customization

1. **Personal Information**: Edit `lib/constants/strings.dart`
2. **Projects**: Update `lib/data/project_data.dart`
3. **Theme Colors**: Modify `lib/theme/app_theme.dart`
4. **Links**: Update URLs in `lib/constants/strings.dart`

### Adding Your Resume

Place your resume PDF at `web/assets/resume.pdf` for the download button to work.

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── constants/
│   └── strings.dart          # All text content
├── data/
│   └── project_data.dart     # Projects and skills data
├── models/
│   └── project.dart          # Data models
├── screens/
│   └── home_screen.dart      # Main screen with navigation
├── sections/
│   ├── hero_section.dart
│   ├── featured_project_section.dart
│   ├── project_gallery_section.dart
│   ├── technical_toolkit_section.dart
│   ├── about_section.dart
│   └── contact_footer.dart
├── theme/
│   └── app_theme.dart        # Colors, typography, theme
└── widgets/
    ├── animated_gradient_text.dart
    ├── navigation_bar.dart
    ├── primary_button.dart
    ├── project_card.dart
    ├── section_header.dart
    └── tech_badge.dart
```

## Deployment

### GitHub Pages

```bash
flutter build web --release --base-href "/repository-name/"
```

### Firebase Hosting

```bash
firebase init hosting
flutter build web --release
firebase deploy
```

## Tech Stack

- **Framework**: Flutter Web
- **Language**: Dart
- **Fonts**: Google Fonts (Inter)
- **Icons**: Font Awesome Flutter
- **URL Handling**: url_launcher

---

Built with ❤️ using Flutter Web
