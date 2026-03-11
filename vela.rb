# Homebrew formula for vela-cli.
#
# After publishing to PyPI, update `url` and `sha256` with the release tarball:
#   curl -s https://pypi.org/pypi/vela-cli/json | jq '.urls[] | select(.packagetype=="sdist") | {url, digests}'
#
# To regenerate all resource SHA256s:
#   pip install homebrew-pypi-poet
#   poet -f vela-cli

class Vela < Formula
  include Language::Python::Virtualenv

  desc "Runtime observability CLI for AI agents"
  homepage "https://vela.wtf"
  url "https://files.pythonhosted.org/packages/source/v/vela-cli/vela_cli-0.1.0.tar.gz"
  sha256 "337e9de67d7e0135fdd05ab55d074418b69ca273811ab3cfaaf97e358de209b1"
  license "MIT"

  # HEAD install from GitHub (useful before first PyPI release)
  head "https://github.com/vela-ai/vela.git", branch: "main"

  depends_on "python@3.12"

  # ── Core dependencies ────────────────────────────────────────────────────
  # Run `poet -f vela-cli` after publishing to get real SHA256s.

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/source/r/rich/rich-13.7.0.tar.gz"
    sha256 "5cb5123b5cf9ee70584244246816e9114227e0b98ad9176eede6ad54bf5403fa"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/39/08/aaaad47bc4e9dc8c725e68f9d04865dbcb2052843ff09c97b08904852d84/urllib3-2.6.3-py3-none-any.whl"
    sha256 "bf272323e553dfb2e87d9bfd225ca7b0f467b919d7bbd355436d3fd37cb0acd4"
  end

  def install
    # Install into an isolated virtualenv managed by Homebrew
    virtualenv_install_with_resources
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/vela --version")
    assert_match "login", shell_output("#{bin}/vela --help")
  end
end
