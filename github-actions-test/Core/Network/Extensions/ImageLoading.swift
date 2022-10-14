//
//  ImageLoading.swift
//  kapida
//
//  Created by Mert Karabulut on 20.05.2021.
//

import Kingfisher

extension UIImageView {
    public func loadImage(
        with urlString: String?,
        animated: Bool = true,
        placeholder: String? = nil,
        placeholderImage: UIImage? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        loadImage(
            with: URL(string: urlString ?? ""),
            animated: animated,
            placeholder: placeholder,
            placeholderImage: placeholderImage,
            progressBlock: progressBlock,
            completionHandler: completionHandler
        )
    }

    public func loadImage(
        with url: URL?,
        animated: Bool = true,
        placeholder: String? = nil,
        placeholderImage: UIImage? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        let phImage: UIImage?
        if let placeholderImage = placeholderImage {
            phImage = placeholderImage
        } else {
            if let placeholder = placeholder {
                phImage = UIImage(imageLiteralResourceName: placeholder)
            } else {
                phImage = nil
            }
        }

        guard let url = url else {
            image = phImage
            return
        }

        var options: KingfisherOptionsInfo = [
            .targetCache(.default)
        ]

        if animated {
            options.append(.transition(.fade(0.3)))
        }

        kf.setImage(with: ImageResource(downloadURL: url),
                    placeholder: placeholderImage,
                    options: options,
                    progressBlock: progressBlock,
                    completionHandler: completionHandler
        )
    }
}


extension UIButton {
    public func loadImage(
        with urlString: String?,
        for state: UIControl.State,
        animated: Bool = true,
        placeholder: String? = nil,
        placeholderImage: UIImage? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        loadImage(
            with: URL(string: urlString ?? ""),
            for: state,
            animated: animated,
            placeholder: placeholder,
            placeholderImage: placeholderImage,
            progressBlock: progressBlock,
            completionHandler: completionHandler
        )
    }

    public func loadImage(
        with url: URL?,
        for state: UIControl.State = .normal,
        animated: Bool = true,
        placeholder: String? = nil,
        placeholderImage: UIImage? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        let phImage: UIImage?
        if let placeholderImage = placeholderImage {
            phImage = placeholderImage
        } else {
            if let placeholder = placeholder {
                phImage = UIImage(imageLiteralResourceName: placeholder)
            } else {
                phImage = nil
            }
        }

        guard let url = url else {
            setImage(phImage, for: state)
            return
        }

        let modifier = AnyImageModifier { return $0.withRenderingMode(.alwaysOriginal) }

        var options: KingfisherOptionsInfo = [
            .imageModifier(modifier),
            .targetCache(.default)
        ]

        if animated {
            options.append(.transition(.fade(0.5)))
        }

        kf.setImage(
            with: url,
            for: state,
            placeholder: placeholderImage,
            options: options,
            progressBlock: progressBlock,
            completionHandler: completionHandler
        )
    }
}
