require "rails_helper"

RSpec.describe Section, type: :model do
  describe "associations" do
    it "belongs to cv" do
      association = described_class.reflect_on_association(:cv)
      expect(association.macro).to eq(:belongs_to)
    end

    it "has many certificates" do
      association = described_class.reflect_on_association(:certificates)
      expect(association.macro).to eq(:has_many)
    end

    it "has many courses" do
      association = described_class.reflect_on_association(:courses)
      expect(association.macro).to eq(:has_many)
    end

    it "has many educations" do
      association = described_class.reflect_on_association(:educations)
      expect(association.macro).to eq(:has_many)
    end

    it "has many employments" do
      association = described_class.reflect_on_association(:employments)
      expect(association.macro).to eq(:has_many)
    end

    it "has many languages" do
      association = described_class.reflect_on_association(:languages)
      expect(association.macro).to eq(:has_many)
    end

    it "has many references" do
      association = described_class.reflect_on_association(:references)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe "enums" do
    it "defines names" do
      expect(described_class.names.keys).to include("certificates_section", "custom_section")
    end

    it "defines horizontal positions" do
      expect(described_class.horizontal_positions.keys).to match_array(%w[main_body side_body])
    end
  end

  describe ".get_horizontal_positions" do
    it "returns the horizontal position values" do
      expect(described_class.get_horizontal_positions).to eq(main_body: "main_body", side_body: "side_body")
    end
  end

  describe ".get_human_names" do
    it "returns translated section names" do
      expect(described_class.get_human_names).to include(
        I18n.t("activerecord.attributes.section.names.certificates_section") => :certificates_section
      )
    end
  end

  describe ".get_human_horizontal_positions" do
    it "returns translated horizontal positions" do
      expected = {
        I18n.t("activerecord.attributes.section.horizontal_positions.main_body") => :main_body,
        I18n.t("activerecord.attributes.section.horizontal_positions.side_body") => :side_body
      }

      expect(described_class.get_human_horizontal_positions).to eq(expected)
    end
  end
end
