if [[ -f "${PODS_ROOT}/SwiftLint/swiftlint" ]]; then
  ${PODS_ROOT}/SwiftLint/swiftlint autocorrect
else
  echo "warning: SwiftLint is not installed. Run 'pod install --repo-update' to install it."
fi
