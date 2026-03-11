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

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/1d/35/02daf95b9cd686320bb622eb148792655c9412dbb9b67abb5694e5910a24/charset_normalizer-3.4.5.tar.gz"
    sha256 "95adae7b6c42a6c5b5b559b1a99149f090a57128155daeea91732c8d970d8644"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/af/2d/7bf41579a8986e348fa033a31cdd0e4121114f6bce2457e8876010b092dd/certifi-2026.2.25.tar.gz"
    sha256 "e887ab5cee78ea814d3472169153c2d12cd43b14bd03329a39a9c6e2e80bfba7"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/6f/6d/0703ccc57f3a7233505399edb88de3cbd678da106337b9fcde432b65ed60/idna-3.11.tar.gz"
    sha256 "795dafcc9c04ed0c1fb032c2aa73654d8e8c5023a7df64a53f39190ada629902"
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
