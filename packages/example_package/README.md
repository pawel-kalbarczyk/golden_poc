# Example package

A simple showcase for monorepo package with melos

## Resources

- https://blog.codemagic.io/flutter-monorepos/
- https://medium.com/flutter-community/how-to-manage-your-flutter-monorepos-b307cdc9399a
- https://github.com/invertase/melos 

## Advantages

- Code Reuse: Split your codebase into small independent packages, which is great for code reuse and testing
- Better CI: With a monorepo you can easily trigger the CI when changing something else in your repository, like trigger the Flutter Integration tests, when making changes to the backend
- Dependency management: Have local packages without the need of a dependency manager, like .
- Enforcing Layered Architecture: Enforce yourself and your team to apply a layered architecture by splitting the layers into multiple packages
- Everything in one place: New developers just clone the monorepo and having in one repository

## Disadvantages

- More overhead: You need to set up tools to manage the repository
- No per-project access control: When having everything in one repository, everyone with repository access can access everything.

## Challenges

- Get the dependencies for all packages
- Check linting for all packages
- Check formatting for all packages
- Run tests for all packages
- Other challenges (like running build_runner in all packages, merge code coverage for all packages, etc.)